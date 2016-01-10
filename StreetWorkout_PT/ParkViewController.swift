//
//  ParkViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 29/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import UIKit

private let addParksIndex = 0
private let parkIdentifier = "ParkCell"
private let addParkNewIdentifier = "AddParkCell"
private let toParkDetailIdentifier = "toParkDetailViewController"
private let toAddParkIdentifier = "toAddParkViewController"

class ParkViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "Parks Table"
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
    
    
    
    func createUserPark() {
        let alert = UIAlertController(title: "Add New Park",
            message: "Add a new park below",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default,
            handler: nil)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { action in
                let nameTextField = alert.textFields![0]
                let locationTextField = alert.textFields![1]
                let coordinatesTextField = alert.textFields![2]
                let rateTextField = alert.textFields![3]
                let equipmentDetailsTextField = alert.textFields![4]
                
                let park = Park()
                park.userCreated = true
                park.name = nameTextField.text
                park.location = locationTextField.text
                park.coordinates = coordinatesTextField.text
                park.rate = rateTextField.text
                park.equipmentDetails = equipmentDetailsTextField.text
                
                //create default
                park.photoFileName = "customPark"
                
                self.dataModel.addPark(park)
                
                self.updateEditButtonVisibility()
                
                self.tableView.reloadData()
        }
        
        alert.addTextFieldWithConfigurationHandler {
            textField in
            textField.placeholder = "Name"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            textField in
            textField.placeholder = "Location"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            textField in
            textField.placeholder = "Coordinates"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            textField in
            textField.placeholder = "Rate"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            textField in
            textField.placeholder = "Equipment Details (Optional)"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == toAddParkIdentifier {
            let destinationViewController = segue.destinationViewController as! AddParkViewController
            destinationViewController.dataModel = dataModel
        } else if segue.identifier == toParkDetailIdentifier {
            let indexPath = sender as! NSIndexPath
            let destinationViewController = segue.destinationViewController as! ParkDetailViewController
            destinationViewController.park = dataModel.allParks[indexPath.row - 1]
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
        editButton.enabled = dataModel.containsUserCreatedPark
    }
    
}

extension ParkViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.allParks.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == addParksIndex {
            cell = tableView.dequeueReusableCellWithIdentifier(addParkNewIdentifier)!
            /*cell.textLabel?.text = "Add New Park"*/
        } else {
            let park = dataModel.allParks[indexPath.row - 1]
            cell = tableView.dequeueReusableCellWithIdentifier(parkIdentifier)!
            (cell as! ParkCell).populate(park)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == addParksIndex {
            return false
        } else {
            return dataModel.allParks[indexPath.row - 1].canRemove
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataModel.removeParkAtIndex(indexPath.row - 1)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            updateEditButtonVisibility()
        }
    }
}

extension ParkViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == addParksIndex {
            performSegueWithIdentifier(toAddParkIdentifier, sender: nil)
        } else {
            performSegueWithIdentifier(toParkDetailIdentifier, sender: indexPath)
        }
    }
}