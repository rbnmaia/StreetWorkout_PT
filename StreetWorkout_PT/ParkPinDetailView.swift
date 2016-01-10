//
//  ParkPinDetailView.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit
import MapKit

class ParkPinDetailView : UIView {
    
    
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var ratingImages: [UIStackView]!
    
    var currentUserLocation: CLLocationCoordinate2D?
    
    var mapPark: MapPark! {
        didSet {
            detailsLabel.text = mapPark.details
            
            updateRating()
        }
    }
    
    //MARK:- Updating UI
    private func updateRating() {
        var count = mapPark.rating.value
        for imageView in ratingImages {
            if (count > 0) {
                imageView.hidden = false
                count--
            } else {
                imageView.hidden = true
            }
        }
    }
}

extension ParkPinDetailView {
    
    //MARK:- IBActions
    
    private func animateView(view: UIView, toHidden hidden: Bool) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(), animations: {
            view.hidden = hidden
            }, completion: nil)
    }
    
}
