//
//  ParkCell.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 29/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit

class ParkCell: UITableViewCell {

    @IBOutlet weak var parkName: UILabel!
    
    func populate(park: Park) {
        parkName.text = park.name
    }
    
}