//
//  DataModelTests.swift
//  StreetWorkout_PT
//
//  Created by Ruben Maia on 09/01/16.
//  Copyright © 2016 Ruben Maia. All rights reserved.
//

import XCTest
@testable import StreetWorkout_PT

class DataModelTests: XCTestCase {
    var dataModel: DataModel!
    
    override func setUp() {
        super.setUp()
        
        dataModel = DataModel()
    }
    
    func testSampleDataAdded() {
        XCTAssert(dataModel.allWorkouts.count > 0)
        XCTAssert(dataModel.allExercises.count > 0)
    }
    
    func testAllWorkoutsEqualsWorkoutsArray() {
        XCTAssertEqual(dataModel.workouts,
            dataModel.allWorkouts)
    }
    
    func testAllExercisesEqualsExercisesArray() {
        XCTAssertEqual(dataModel.exercises,
            dataModel.allExercises)
    }
    
    func testContainsUserCreatedWorkout() {
        XCTAssertFalse(dataModel.containsUserCreatedWorkout)
        
        let workout1 = Workout()
        dataModel.addWorkout(workout1)
        
        XCTAssertFalse(dataModel.containsUserCreatedWorkout)
        
        let workout2 = Workout()
        workout2.userCreated = true
        dataModel.addWorkout(workout2)
        
        XCTAssert(dataModel.containsUserCreatedWorkout)
        
        dataModel
            .removeWorkoutAtIndex(dataModel.allWorkouts.count - 1)
        XCTAssertFalse(dataModel.containsUserCreatedWorkout)
    }
    
    func testContainsUserCreatedExercise() {
        XCTAssertFalse(dataModel.containsUserCreatedExercise)
        
        let exercise1 = Exercise()
        dataModel.addExercise(exercise1)
        
        XCTAssertFalse(dataModel.containsUserCreatedExercise)
        
        let exercise2 = Exercise()
        exercise2.userCreated = true
        dataModel.addExercise(exercise2)
        
        XCTAssert(dataModel.containsUserCreatedExercise)
        
        dataModel
            .removeExerciseAtIndex(dataModel.allExercises.count - 1)
        XCTAssertFalse(dataModel.containsUserCreatedExercise)
    }
}