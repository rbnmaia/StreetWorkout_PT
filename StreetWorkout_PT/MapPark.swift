//
//  Park.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct MapPark {
    let name: String
    let location: CLLocationCoordinate2D
    let category: String
    let details: String
    let rating: ParkRating
    
    static var timeZone = NSTimeZone(abbreviation: "PST")!
    
    init?(dictionary: [String : AnyObject]) {
        guard let name = dictionary["name"] as? String,
            let category = dictionary["category"] as? String,
            let details = dictionary["details"] as? String,
            let ratingRaw = dictionary["rating"] as? Int,
            let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double,
            let rating = ParkRating(value: ratingRaw) else {
                return nil
        }
        
        self.name = name
        self.category = category
        self.details = details
        self.rating = rating
        
        self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
    }
    
    static func allMapParks() -> [MapPark] {
        guard let path = NSBundle.mainBundle().pathForResource("PortugalStreetWorkout_Parks", ofType: "plist"),
            let array = NSArray(contentsOfFile: path) as? [[String : AnyObject]] else {
                return [MapPark]()
        }
        
        // 1
        let parks = array.flatMap { MapPark(dictionary: $0) }
            .sort { $0.name < $1.name }
        
        // 2
        let first = parks.first!
        let location = CLLocation(latitude: first.location.latitude,
            longitude: first.location.longitude)
        
        // 3
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, _) -> Void in
            if let placemark = placemarks?.first, timeZone = placemark.timeZone {
                self.timeZone = timeZone
            }
        }
        
        return parks
    }
}

extension MapPark : CustomStringConvertible {
    var description : String {
        return "\(name): \(details)"
    }
}

enum ParkRating {
    case Unknown
    case Rating(Int)
    
    init?(value: Int) {
        if value > 0 && value <= 5 {
            self = .Rating(value)
        } else {
            self = .Unknown
        }
    }
    
    var value : Int {
        switch self {
        case .Unknown:
            return 0
        case .Rating(let value):
            return value
        }
    }
}