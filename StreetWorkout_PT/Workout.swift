//
//  Workout.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import Foundation

class Workout : NSObject {
  
  var userCreated = false
  var name: String!
  var restInterval: NSTimeInterval = 0.0
  var exercises = [Exercise]()
  private var workoutCounter = 0
  
  var workoutCount: Int {
    return workoutCounter
  }
  
  var canEdit: Bool {
    return userCreated
  }
    
  var canRemove: Bool {
    return userCreated
  }
  
  var duration: NSTimeInterval {
    var totalDuration: NSTimeInterval = 0
    for exercise in exercises {
      totalDuration += exercise.duration
    }
    
    let numIntervals = max(0, exercises.count - 1)
    totalDuration += Double(numIntervals) * restInterval
    
    return totalDuration
  }
  
  func addExercise(exercise: Exercise) {
    exercises.append(exercise)
  }
  
  func removeExercise(exercise: Exercise) -> Bool {
    return true
  }
  
  func performWorkout() {
    workoutCounter++
  }
}
