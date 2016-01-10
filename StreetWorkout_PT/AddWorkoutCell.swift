//
//  AddWorkoutCell.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import UIKit

class AddWorkoutCell: UITableViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()
    self.accessoryView = UIImageView(image: UIImage(named: "addIcon"))
  }
  
}
