//
//  Park.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 29/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import Foundation
import UIKit

class Park : NSObject {
    
    var userCreated = false
    var name: String!
    var location: String!
    var coordinates: String!
    var category: String!
    var photoFileName: String!
    var rate: String!
    var equipmentDetails: String!
    
    var canEdit: Bool {
        return userCreated
    }
    
    var canRemove: Bool {
        return userCreated
    }
    
    var thumbnail: UIImage? {
        return resizeImageWithSize(CGSizeMake(50, 50))
    }
    
    //MARK - Helper methods
    
    private func resizeImageWithSize(size: CGSize) ->  UIImage? {
        
        if let image = UIImage(named: photoFileName) {
            UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
            image.drawInRect(CGRectMake(0, 0, size.width, size.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
        
        return nil
    }
    
}

