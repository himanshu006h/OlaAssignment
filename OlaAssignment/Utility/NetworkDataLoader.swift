//
//  File.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation

typealias QueryCompletionHandler = (_ result : FetchResult) -> Void
typealias FetchResult = Result<Any, APIErrors>

enum ServiceType: Int {
    case mapDetails = 0
}

struct NetworkDataLoaderConstant {
    static let baseUrlString = "http://www.mocky.io/v2/5dc3f2c13000003c003477a0"
    static let getMethod = "GET"
}

class NetworkDataLoader {
    var dataTask: URLSessionDataTask?
    let decoder = JSONDecoder()
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func loadResult(urlString: String = NetworkDataLoaderConstant.baseUrlString, serviceType: ServiceType = ServiceType.mapDetails
        , bodyPram: [String: Any] = [String: Any](), completion: @escaping QueryCompletionHandler) {
        
        var request: URLRequest
        switch serviceType {
        case .mapDetails:
            request = urlString.urlRequest()
        }
        
        dataTask = session.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                completion(.failure(.requestFailed(error: error as NSError)))
                return
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 || response.statusCode == 201 {
                self.parseData((String(data:data,
                                       encoding:.isoLatin1)!.data(using: .utf8)!), serviceType: serviceType, completion: { result in
                                        switch result {
                                        case let .success(feedInfo): completion(.success(feedInfo))
                                        case let .failure(error) : completion(.failure(error))
                                        }
                })
            }else{
                if (response as? HTTPURLResponse) != nil{
                    completion(.failure(.responseUnsuccessful))
                }
            }
        }
        dataTask?.resume()
    }
    
    //Parse Data as per service type
    private func parseData(_ data: Data, serviceType: ServiceType = ServiceType.mapDetails, completion: QueryCompletionHandler) {
        switch serviceType {
        case .mapDetails:
            do {
                let mapInfo = try decoder.decode([MapDetailsModel].self, from: data)
                completion(.success(mapInfo))
            } catch _ as NSError {
                completion(.failure(.jsonParsingFailure))
                return
            }
        }
    }
}

