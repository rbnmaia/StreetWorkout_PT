//
//  ExerciseImageViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit

class ExerciseImageViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  
  var exercise: Exercise!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = exercise.name
    imageView.image = UIImage(named: exercise.photoFileName)
  }
}
