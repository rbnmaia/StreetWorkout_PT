//
//  AddParkViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit

private let infoCellIdentifier = "AddParkInfoCell"
private let detailsCellIdentifier = "AddParkDetailsCell"

class AddParkViewController: UIViewController{
    
  
    var nameTextField: UITextField!
    var locationTextField: UITextField!
    var coordinatesTextField: UITextField!
    var rateTextField: UITextField!
    var equipmentDetailsTextView: UITextView!
    var dataModel: DataModel!
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let park = Park()
        park.userCreated = true
        park.name = nameTextField.text
        
        dataModel.addPark(park)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func photosButtonTapped(sender: AnyObject) {
        
    }
    
    
    // MARK - Helper methods
    
    func parkInfoCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(infoCellIdentifier) as! AddParkInfoCell
        cell.selectionStyle = .None
        
        if indexPath.row == 0 {
            cell.infoLabel.text = "Name"
            cell.infoTextField.placeholder = "Park name"
            nameTextField = cell.infoTextField
        }
        if indexPath.row == 1 {
            cell.infoLabel.text = "Location"
            cell.infoTextField.placeholder = "Location"
            locationTextField = cell.infoTextField
        }
        if indexPath.row == 2  {
            cell.infoLabel.text = "Coordinates"
            cell.infoTextField.placeholder = "e.g. 39.733817, -8.821383"
            cell.infoTextField.keyboardType = .NumberPad
            coordinatesTextField = cell.infoTextField
        }
        if indexPath.row == 3 {
            cell.infoLabel.text = "Rate"
            cell.infoTextField.placeholder = "e.g. 4"
            cell.infoTextField.keyboardType = .NumberPad
            rateTextField = cell.infoTextField
        }
        return cell
    }
    
    func parkDetailsCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(detailsCellIdentifier) as! AddParkDetailsCell
        cell.selectionStyle = .None
        
        if indexPath.row == 0 {
            cell.equipmentDetailsLabel.text = "Equipment Details"
            cell.equipmentDetailsTextView.text = "Placeholder"
            equipmentDetailsTextView = cell.equipmentDetailsTextView
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Park Info" : "Add Equipment Details"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGrayColor()
            
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGrayColor() && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
}