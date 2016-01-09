//
//  ExerciseTests.swift
//  StreetWorkout_PT
//
//  Created by Ruben Maia on 09/01/16.
//  Copyright © 2016 Ruben Maia. All rights reserved.
//

import XCTest
@testable import StreetWorkout_PT

class ExerciseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExerciseCanEdit() {
        let builtInExercise = Exercise()
        builtInExercise.userCreated = false
        
        let userCreatedExercise = Exercise()
        userCreatedExercise.userCreated = true
        
        XCTAssertFalse(builtInExercise.canEdit, "Bulit-in exercises are not editable")
        XCTAssertTrue(userCreatedExercise.canEdit, "User-created exercises are editable")
    }
    
    func testExerciseCanRemove() {
        let builtInExercise = Exercise()
        builtInExercise.userCreated = false
        
        let userCreatedExercise = Exercise()
        userCreatedExercise.userCreated = true
        
        XCTAssertFalse(builtInExercise.canRemove, "Built-in exercises are not removable")
        XCTAssertTrue(userCreatedExercise.canRemove, "User-created exercises are removable")
    }
    
}