//
//  WorkoutViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import UIKit

private let addWorkoutIndex = 0
private let addNewIdentifier = "AddWorkoutCell"
private let workoutIdentifier = "WorkoutCell"
private let toWorkoutDetailIdentifier = "toWorkoutDetailViewController"
private let toAddWorkoutIdentifier = "toAddWorkoutViewController"

class WorkoutViewController: UIViewController {
  
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var tableView: UITableView!
    
  let dataModel = DataModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.accessibilityIdentifier = "Workouts Table"
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    updateEditButtonVisibility()
    toggleEditMode(false)
    
    tableView.reloadData()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == toAddWorkoutIdentifier {
      let destinationViewController = segue.destinationViewController as! AddWorkoutViewController
      destinationViewController.dataModel = dataModel
    } else if segue.identifier == toWorkoutDetailIdentifier {
      let indexPath = sender as! NSIndexPath
      let destinationViewController = segue.destinationViewController as! WorkoutDetailViewController
      destinationViewController.workout = dataModel.allWorkouts[indexPath.row - 1]
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
    editButton.enabled = dataModel.containsUserCreatedWorkout
  }
}

extension WorkoutViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel.allWorkouts.count + 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    
    if indexPath.row == addWorkoutIndex {
      cell = tableView.dequeueReusableCellWithIdentifier(addNewIdentifier)!
    } else {
      let workout = dataModel.allWorkouts[indexPath.row - 1]
      cell = tableView.dequeueReusableCellWithIdentifier(workoutIdentifier)!
      (cell as! WorkoutCell).populate(workout)
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    if indexPath.row == addWorkoutIndex {
      return false
    } else {
      return dataModel.allWorkouts[indexPath.row - 1].canEdit
    }
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      dataModel.removeWorkoutAtIndex(indexPath.row - 1)
      
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      updateEditButtonVisibility()
    }
  }
  
}

extension WorkoutViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == addWorkoutIndex {
      performSegueWithIdentifier(toAddWorkoutIdentifier, sender: nil)
    } else {
      performSegueWithIdentifier(toWorkoutDetailIdentifier, sender: indexPath)
    }
  }
}
