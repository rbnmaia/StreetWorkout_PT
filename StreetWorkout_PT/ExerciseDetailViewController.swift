//
//  ExerciseDetailViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit
import Social

private let toExerciseImageIdentifier = "toExerciseImageViewController"

class ExerciseDetailViewController: UITableViewController {
  
  var exercise: Exercise!
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var exerciseImageView: UIImageView!
  @IBOutlet weak var durationLabel: UILabel!
  @IBOutlet weak var instructionsLabel: UILabel!
    
    override func viewDidLoad() {
    super.viewDidLoad()
   
    title = exercise.name
    
    nameLabel.text = exercise.name
    exerciseImageView.image = UIImage(named: exercise.photoFileName)
    durationLabel.text = "\(Int(exercise.duration)) seconds"
    instructionsLabel.text = exercise.instructions
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 0 && indexPath.row == 2 {
      performSegueWithIdentifier(toExerciseImageIdentifier, sender: nil)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == toExerciseImageIdentifier {
      let photoVC = segue.destinationViewController as! ExerciseImageViewController
      photoVC.exercise = exercise
    }
  }

    @IBAction func shareSocial(sender: UIButton){
    
        let actionSheet = UIAlertController(title: "", message: "Share your Exercise", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Configure a new action for sharing the note in Twitter.
        /*let tweetAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            // Check if sharing to Twitter is possible.
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                // Initialize the default view controller for sharing the post.
                let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                // Set the note text as the default post message.
                if count(self.instructionsLabel.text!) <= 140 {
                    twitterComposeVC.setInitialText("\(self.instructionsLabel.text)")
                }
                else {
                    let index = advance(self.instructionsLabel.text!.startIndex, 140)
                    let subText = self.instructionsLabel.text!.substringToIndex(index)
                    twitterComposeVC.setInitialText("\(subText)")
                }
                // Display the compose view controller.
                self.presentViewController(twitterComposeVC, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage("You are not logged in to your Twitter account.")
            }
            
        }*/
        
        
        let facebookAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default){ (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                facebookComposeVC.setInitialText("\(self.instructionsLabel.text)")
                
                self.presentViewController(facebookComposeVC, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage("You are not connected to your Facebook account.")
            }
        }
        
        let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.Default) { (action) -> Void in
            let activityViewController = UIActivityViewController(activityItems: [self.instructionsLabel.text!], applicationActivities: nil)
            
            activityViewController.excludedActivityTypes = [UIActivityTypeMail]
            
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel){ (action) -> Void in
        
        }
        
        /*actionSheet.addAction(tweetAction)*/
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "WooHoo sharing is caring", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}

