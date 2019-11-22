//
//  OlaAssignmentParsingTest.swift
//  OlaAssignmentTests
//
//  Created by Himanshu Saraswat on 22/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import XCTest
@testable import OlaAssignment

class OlaAssignmentParsingTest: XCTestCase {

    struct Constant {
        static let loctionList = "LocationServiceDummy"
        static let json = "json"
        static let dummyId = "WMWOLAID00001"
        static let licensePlate = "KA01AZ4711"
    }
    
    let decoder = JSONDecoder()
    var mapResponse: [MapDetailsModel]!
    
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: Constant.loctionList, ofType: Constant.json)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        mapResponse = try! decoder.decode([MapDetailsModel].self, from: data!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfMap() {
        let expectedRows = 15
        XCTAssertEqual(mapResponse.count, expectedRows)
    }

    func testMapId() {
        let expectedId = Constant.dummyId
        guard let selctedMapContant = mapResponse.first else {
            return
        }
        
        XCTAssertEqual(selctedMapContant.id, expectedId)
    }

}
