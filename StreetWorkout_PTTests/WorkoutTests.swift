//
//  WorkoutTests.swift
//  StreetWorkout_PT
//
//  Created by Ruben Maia on 09/01/16.
//  Copyright © 2016 Ruben Maia. All rights reserved.
//

import XCTest
@testable import StreetWorkout_PT

class WorkoutTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWorkoutCanEdit() {
        let builtInWorkout = Workout()
        builtInWorkout.userCreated = false
        
        let userCreatedWorkout = Workout()
        userCreatedWorkout.userCreated = true
        
        XCTAssertFalse(builtInWorkout.canEdit, "Buit-in workouts are not editable")
        XCTAssertTrue(userCreatedWorkout.canEdit, "User-created workouts are editable")
    }
    
    func testWorkoutCanRemove() {
        let builtInWorkout = Workout()
        builtInWorkout.userCreated = false
        
        let userCreatedWorkout = Workout()
        userCreatedWorkout.userCreated = true
        
        XCTAssertFalse(builtInWorkout.canRemove, "Bulit-in workouts are not removable")
        XCTAssertTrue(userCreatedWorkout.canRemove, "User-created workouts are removable")
    }
    
    func testWorkoutDurationSumOfPartsNoInterval() {
        let workoutWithoutExercises = Workout()
        XCTAssertEqual(workoutWithoutExercises.duration, 0, "A workout with no exercises should have duration of 0")
        
        let exercise1 = Exercise()
        exercise1.duration = 20
        
        let exercise2 = Exercise()
        exercise2.duration = 60
        
        let exercise3 = Exercise()
        exercise3.duration = 15
        
        let workoutWithOneExercise = Workout()
        workoutWithOneExercise.addExercise(exercise1)
        XCTAssertEqual(workoutWithOneExercise.duration, exercise1.duration, "A workout with one exercise should have duration of its exercise")
        
        let workoutWithMultipleExercises = Workout()
        workoutWithMultipleExercises.addExercise(exercise1)
        workoutWithMultipleExercises.addExercise(exercise2)
        workoutWithMultipleExercises.addExercise(exercise3)
        XCTAssertEqual(workoutWithMultipleExercises.duration, exercise1.duration + exercise2.duration + exercise3.duration, "A workout with multiple exercises should have duration of the sum of its exercises")
    }
    
    func testWorkoutDurationSumOfPartsWithInterval() {
        let workoutWithoutExercises = Workout()
        workoutWithoutExercises.restInterval = 10
        XCTAssertEqual(workoutWithoutExercises.duration, 0, "A workout with no exercises and a non-zero rest interval should have duration of 0")
        
        let exercise1 = Exercise()
        exercise1.duration = 20
        
        let exercise2 = Exercise()
        exercise2.duration = 60
        
        let exercise3 = Exercise()
        exercise3.duration = 15
        
        let workoutWithOneExercise = Workout()
        workoutWithOneExercise.restInterval = 10
        workoutWithOneExercise.addExercise(exercise1)
        XCTAssertEqual(workoutWithOneExercise.duration, exercise1.duration, "A workout with one exercise and a rest interval should not include the rest interval in the duration of the workout")
        
        let workoutWithMultipleExercises = Workout()
        workoutWithMultipleExercises.restInterval = 10
        workoutWithMultipleExercises.addExercise(exercise1)
        workoutWithMultipleExercises.addExercise(exercise2)
        workoutWithMultipleExercises.addExercise(exercise3)
        XCTAssertEqual(workoutWithMultipleExercises.duration, exercise1.duration + workoutWithMultipleExercises.restInterval +  exercise2.duration + workoutWithMultipleExercises.restInterval + exercise3.duration, "A workout with multiple exercises should have duration of the sum of its exercises plus any rest intervals")
    }
    
}