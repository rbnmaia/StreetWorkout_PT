//
//  AddParkCell.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 08/01/16.
//  Copyright © 2016 ESTG-IPLeiria. All rights reserved.
//

import UIKit

class AddParkCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryView = UIImageView(image: UIImage(named: "addIcon"))
    }
    
}

