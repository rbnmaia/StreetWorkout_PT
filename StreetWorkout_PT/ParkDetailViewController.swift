//
//  ParkDetailViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 29/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import UIKit
import Social

private let toParkImageIdentifier = "toParkImageViewController"

class ParkDetailViewController: UITableViewController {
    
    var park: Park!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var localtionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var parkImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var equipmentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = park.name
        
        nameLabel.text = park.name
        localtionLabel.text = park.location
        categoryLabel.text = park.category
        coordinatesLabel.text = park.coordinates
        parkImageView.image = UIImage(named: park.photoFileName)
        rateLabel.text = park.rate
        equipmentTextView.text = park.equipmentDetails
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            performSegueWithIdentifier(toParkImageIdentifier, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == toParkImageIdentifier {
            let photoVC = segue.destinationViewController as! ParkImageViewController
            photoVC.park = park
        }
    }
    
    @IBAction func shareSocial(sender: UIButton){
        
        let actionSheet = UIAlertController(title: "", message: "Share your Exercise", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        /*// Configure a new action for sharing the note in Twitter.
        let tweetAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.Default) { (action) -> Void in
        
        // Check if sharing to Twitter is possible.
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
        // Initialize the default view controller for sharing the post.
        let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // Set the note text as the default post message.
        if count(self.equipmentTextView.text!) <= 140 {
        twitterComposeVC.setInitialText("\(self.equipmentTextView.text)")
        }
        else {
        let index = advance(self.equipmentTextView.text!.startIndex, 140)
        let subText = self.equipmentTextView.text!.substringToIndex(index)
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
                
                facebookComposeVC.setInitialText("\(self.equipmentTextView.text)")
                
                self.presentViewController(facebookComposeVC, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage("You are not connected to your Facebook account.")
            }
        }
        
        let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.Default) { (action) -> Void in
            let activityViewController = UIActivityViewController(activityItems: [self.equipmentTextView.text!], applicationActivities: nil)
            
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
