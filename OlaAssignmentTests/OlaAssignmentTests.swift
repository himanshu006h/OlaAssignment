//
//  OlaAssignmentTests.swift
//  OlaAssignmentTests
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import XCTest
@testable import OlaAssignment

class OlaAssignmentTests: XCTestCase {
    
    struct Constants {
        static let StatusCodeDict = "Status code : 200"
        static let completionHandlerMsg = "Call completes immediately by invoking completion handler"
        static let testURL = "http://www.mocky.io/v2/5dc3f2c13000003c003477a0"
    }
    
    var sessionUnderTest : URLSession!

    override func setUp() {
        sessionUnderTest = URLSession(configuration : URLSessionConfiguration.default)
    }

    override func tearDown() {
        sessionUnderTest = nil
    }

    func testValidCallToInfoAPIGetsStatusCode200(){
        let request = Constants.testURL.urlRequest()
        let promise = expectation(description: Constants.StatusCodeDict)
        
        // when
        sessionUnderTest.dataTask(with: request) { (data, response, error) in
            // then
            if let error = error{
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else{
                    XCTFail("Status code = \(statusCode)")
                }
            }
            }.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }

}
