//
//  ParkTests.swift
//  StreetWorkout_PT
//
//  Created by Ruben Maia on 09/01/16.
//  Copyright © 2016 Ruben Maia. All rights reserved.
//

import XCTest
@testable import StreetWorkout_PT

class ParkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParkCanEdit() {
        let builtInPark = Park()
        builtInPark.userCreated = false
        
        let userCreatedPark = Park()
        userCreatedPark.userCreated = true
        
        XCTAssertFalse(builtInPark.canEdit, "Bulit-in parks are not editable")
        XCTAssertTrue(userCreatedPark.canEdit, "User-created parks are editable")
    }
    
    func testParkCanRemove() {
        let builtInPark = Park()
        builtInPark.userCreated = false
        
        let userCreatedPark = Park()
        userCreatedPark.userCreated = true
        
        XCTAssertFalse(builtInPark.canRemove, "Built-in parks are not removable")
        XCTAssertTrue(userCreatedPark.canRemove, "User-created parks are removable")
    }
    
}