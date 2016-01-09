//
//  WorkoutsUITests.swift
//  StreetWorkout_PT
//
//  Created by Ruben Maia on 09/01/16.
//  Copyright © 2016 Ruben Maia. All rights reserved.
//

import XCTest

class WorkoutsUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func test7MinuteWorkout() {
        
        let app = XCUIApplication()
        app.tables["Workouts Table"].staticTexts["7 Minute Workout"].tap()
        
        let workoutDetailTableTable = app.tables["Workout Detail Table"]
        workoutDetailTableTable.otherElements["EXERCISES"].swipeUp()
        workoutDetailTableTable.buttons["Select & Workout"].tap()
        app.alerts["Woo hoo! You worked out!"].collectionViews.buttons["OK"].tap()
        app.navigationBars["7 Minute Workout"].buttons["Workouts"].tap()
    }
    
}