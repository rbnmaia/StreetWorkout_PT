//
//  AddWorkoutExerciseCell.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit

class AddWorkoutExerciseCell: UITableViewCell {

  func populate(exercise: Exercise) {
    textLabel!.text = exercise.name
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    if selected {
      accessoryType = .Checkmark
    } else {
      accessoryType = .None
    }
  }
  
}
