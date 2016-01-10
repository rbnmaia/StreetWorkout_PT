//
//  ExerciseCell.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {
  
  @IBOutlet weak var exerciseImageView: UIImageView!
  @IBOutlet weak var exerciseName: UILabel!
  
  func populate(exercise: Exercise) {
    exerciseImageView.image = UIImage(named: exercise.photoFileName)
    exerciseName.text = exercise.name
  }
}
