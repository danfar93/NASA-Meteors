//
//  NASATests.swift
//  NASATests
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import XCTest

class NASATests: XCTestCase {
    
    
    override class func setUp() {
        var meteorsFromAPI = [Meteor]()
    }
    
    /// Tests decoding of Meteor object with good json and asserts that no error is thrown
    func testDecodingMeteorFromJsonSuccess() throws {
        
        let path = Bundle.main.path(forResource: "meteor", ofType: "json")!
        let url = NSURL(fileURLWithPath:path)
        let jsonData = try Data(contentsOf: url as URL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        XCTAssertNoThrow(try decoder.decode(Meteor.self, from: jsonData))
    }
    
    
    /// Tests decoding of Meteor object with bad json and asserts that an error is thrown
    func testDecodingMeteorFromJsonError() throws {
        
        let path = Bundle.main.path(forResource: "meteor-bad", ofType: "json")!
        let url = NSURL(fileURLWithPath:path)
        let jsonData = try Data(contentsOf: url as URL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        XCTAssertThrowsError(try decoder.decode(Meteor.self, from: jsonData))
    }
    
}
