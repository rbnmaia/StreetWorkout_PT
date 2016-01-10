//
//  ExerciseViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit

private let addWorkoutIndex = 0
private let exerciseIdentifier = "ExerciseCell"
private let addExerciseNewIdentifier = "AddWorkoutCell"
private let toDetailSegue = "toExerciseDetailViewController"

class ExerciseViewController: UIViewController {
  
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var tableView: UITableView!
  
  let dataModel = DataModel()
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    updateEditButtonVisibility()
    toggleEditMode(false)
  }

  func createUserExercise() {
    let alert = UIAlertController(title: "Add New Exercise",
      message: "Add a new exercise below",
      preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "Cancel",
      style: .Default,
      handler: nil)
    
    let saveAction = UIAlertAction(title: "Save",
      style: .Default) { action in
        let nameTextField = alert.textFields![0]
        let durationTextField = alert.textFields![1]
        let instructionsTextField = alert.textFields![2]
        
        let exercise = Exercise()
        exercise.userCreated = true
        exercise.name = nameTextField.text
        exercise.duration = Double(durationTextField.text!)
        exercise.instructions = instructionsTextField.text
        
        //create default
        exercise.photoFileName = "customExercise"
        
        self.dataModel.addExercise(exercise)

        self.updateEditButtonVisibility()
        
        self.tableView.reloadData()
    }
    
    alert.addTextFieldWithConfigurationHandler {
      textField in
      textField.placeholder = "Name"
    }
    
    alert.addTextFieldWithConfigurationHandler {
      textField in
      textField.keyboardType = .NumberPad
      textField.placeholder = "e.g. 30"
    }
    
    alert.addTextFieldWithConfigurationHandler {
      textField in
      textField.placeholder = "Instructions (Optional)"
    }
    
    alert.addAction(cancelAction)
    alert.addAction(saveAction)
    
    self.presentViewController(alert,
      animated: true,
      completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == toDetailSegue {
      let indexPath = sender as! NSIndexPath
      let detailViewController = segue.destinationViewController as! ExerciseDetailViewController
      detailViewController.exercise = dataModel.allExercises[indexPath.row - 1]
    }
  }
  
  @IBAction func editButtonTapped(sender: UIBarButtonItem) {
    toggleEditMode(!tableView.editing)
  }
  
  private func toggleEditMode(editing: Bool) {
    tableView.setEditing(editing, animated: true)
    
    editButton.title = editing ? "Done" : "Edit"
  }
  
  private func updateEditButtonVisibility() {
    editButton.enabled = dataModel.containsUserCreatedExercise
  }
}

extension ExerciseViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel.allExercises.count + 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    
    if indexPath.row == addWorkoutIndex {
      cell = tableView.dequeueReusableCellWithIdentifier(addExerciseNewIdentifier)!
      cell.textLabel?.text = "Add New Exercise"
    } else {
      cell = tableView.dequeueReusableCellWithIdentifier(exerciseIdentifier)!

      let exercise = dataModel.allExercises[indexPath.row - 1]
      (cell as! ExerciseCell).populate(exercise)
    }
    
    return cell
  }

  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    if indexPath.row == addWorkoutIndex {
      return false
    } else {
      return dataModel.allExercises[indexPath.row - 1].canRemove
    }
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      dataModel.removeExerciseAtIndex(indexPath.row - 1)
      
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      updateEditButtonVisibility()
    }
  }
}

extension ExerciseViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == addWorkoutIndex {
      createUserExercise()
    } else {
      performSegueWithIdentifier(toDetailSegue, sender: indexPath)
    }
  }
}