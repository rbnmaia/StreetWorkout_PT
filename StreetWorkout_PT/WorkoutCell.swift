//
//  WorkoutCell.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit

class WorkoutCell: UITableViewCell {

  func populate(workout: Workout) {
    textLabel!.text = workout.name
    detailTextLabel!.text = "\(workout.exercises.count) exercises"
  }
}
