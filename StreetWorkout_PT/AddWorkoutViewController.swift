//
//  AddWorkoutViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit

private let infoCellIdentifier = "AddWorkoutInfoCell"
private let exerciseCellIdentifier = "AddWorkoutExerciseCell"

class AddWorkoutViewController: UIViewController {
  
  var nameTextField: UITextField!
  var restIntervalTextField: UITextField!
  var dataModel: DataModel!
  
  @IBOutlet weak var tableView: UITableView!

  @IBAction func saveButtonTapped(sender: AnyObject) {
    let workout = Workout()
    workout.userCreated = true
    workout.name = nameTextField.text
    if let restIntervalText = restIntervalTextField.text,
      restInterval = Double(restIntervalText) {
        workout.restInterval = restInterval
    }
    
    if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
      for indexPath in selectedIndexPaths {
        workout.addExercise(dataModel.allExercises[indexPath.row])
      }
    }
    
    dataModel.addWorkout(workout)

    navigationController?.popViewControllerAnimated(true)
  }
  
  // MARK - Helper methods
  
  func workoutInfoCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(infoCellIdentifier) as! AddWorkoutInfoCell
    cell.selectionStyle = .None
    
    if indexPath.row == 0 {
      cell.infoLabel.text = "Name"
      cell.infoTextField.placeholder = "Workout name"
      nameTextField = cell.infoTextField
    } else {
      cell.infoLabel.text = "Rest Interval"
      cell.infoTextField.placeholder = "e.g. 30"
      cell.infoTextField.keyboardType = .NumberPad
      restIntervalTextField = cell.infoTextField
    }
    
    return cell
  }
  
}

extension AddWorkoutViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return (section == 0) ? "Workout Info" : "Add Exercises"
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (section == 0) ? 2 : dataModel.allExercises.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    
    if indexPath.section == 0 {
      cell = workoutInfoCellForIndexPath(indexPath)
    } else {
      let exercise =  dataModel.allExercises[indexPath.row]
      cell = tableView.dequeueReusableCellWithIdentifier(exerciseCellIdentifier)!

      (cell as! AddWorkoutExerciseCell).populate(exercise)
    }
    
    return cell
  }
  
}
