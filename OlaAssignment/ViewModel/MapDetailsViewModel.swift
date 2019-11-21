//
//  MapDetailsViewModel.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation

protocol MapInformationProtocol: class {
    func updateMapDetails(mapDetails: Any?, error: Error?)
}

struct MapDetailsViewModel {

    //MARK:- Properties
    var mapInfo: [MapDetailsModel]?
    weak var mapDelegate: MapInformationProtocol?
    
    func fetchMapDetails() {
        // Fetch data from the API
        NetworkDataLoader().loadResult { result in
            switch result {
            case let .success(mapInfo):
                self.mapDelegate?.updateMapDetails(mapDetails: mapInfo, error: nil)
                DispatchQueue.main.async {
                    
                }
                // We had handle the error more precisely rather then just printing to console.
            // The specific type of error can generate specific error for the user
            case let .failure(error) :
                self.mapDelegate?.updateMapDetails(mapDetails: nil, error: error)
            }
        }
    }
}
