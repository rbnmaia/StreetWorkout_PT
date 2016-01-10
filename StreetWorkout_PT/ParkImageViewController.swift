//
//  ParkImageViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 29/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import UIKit

class ParkImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var park: Park!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = park.name
        imageView.image = UIImage(named: park.photoFileName)
    }
}
