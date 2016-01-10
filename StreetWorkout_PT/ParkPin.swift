//
//  ParkPin.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//

import Foundation
import MapKit

class ParkPin : NSObject, MKAnnotation {
    let mapPark: MapPark
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(mapPark: MapPark) {
        self.mapPark = mapPark
        self.coordinate = mapPark.location
        self.title = mapPark.name
        /*self.subtitle = mapPark.details*/
    }
}
