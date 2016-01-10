//
//  MapViewController.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 29/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit
import MapKit

class MapViewController: UIViewController{
    
    lazy var locationManager = CLLocationManager()
    var currentUserLocation: CLLocationCoordinate2D?
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var singleTap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        addMapData()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
       
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        requestUserLocation()
    }
    
    private func setupMap() {
        mapView.showsScale = true
        
        let leiria = CLLocationCoordinate2D(latitude: 39.733817, longitude: -8.821383)
        centerMap(mapView, atPosition: leiria)
    }
    
    private func addMapData() {
        for mapPark in MapPark.allMapParks() {
            let annotation = ParkPin(mapPark: mapPark)
            mapView.addAnnotation(annotation)
        }
    }
    
    private func centerMap(map: MKMapView?, atPosition position: CLLocationCoordinate2D?) {
        guard let map = map, let position = position else {
            return
        }
        
        map.setCenterCoordinate(position, animated: true)
        
        let zoomRegion = MKCoordinateRegionMakeWithDistance(position, 1000, 1000)
        map.setRegion(zoomRegion, animated: true)
    }
    
    private func requestUserLocation() {
        mapView.showsUserLocation = true //1
        if CLLocationManager.authorizationStatus() ==
            .AuthorizedWhenInUse { // 2
                locationManager.requestLocation()   // 3
        } else {
            locationManager.requestWhenInUseAuthorization()   // 4
        }
    }
}

// MARK:- MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? ParkPin else {
        return nil
    }
        
    let identifier = "ParkPinDetailView"
        
    var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
    
    if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView!.canShowCallout = true
    }
    
    annotationView!.annotation = annotation
 
        
        /*let detailView = UIView.loadFromNibNamed(identifier) as! ParkPinDetailView
        detailView.mapPark = annotation.mappark
        annotationView!.detailCalloutAccessoryView = detailView*/
        
        return annotationView
    }

    func mapView(mapView: MKMapView,
    didSelectAnnotationView view: MKAnnotationView) {
        if let detailView =
            view.detailCalloutAccessoryView as? ParkPinDetailView {
                detailView.currentUserLocation = currentUserLocation
        }
    }
    
}



// MARK:- CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.AuthorizedAlways || status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
            currentUserLocation = locations.first?.coordinate
    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError) {
            print("Error finding location: \(error.localizedDescription)")
    }
}