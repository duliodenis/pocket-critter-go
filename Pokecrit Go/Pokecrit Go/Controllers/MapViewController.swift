//
//  MapViewController.swift
//  Pokecrit Go
//
//  Created by Dulio Denis on 5/5/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var numberOfUpdates = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        // if we are authorized to show location - display it
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            // otherwise request it
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // MARK: - Update User Location
    
    @IBAction func updateLocation(_ sender: Any) {
        updateMap()
    }
    
    
    // MARK: - Location Manager Delegate Method
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // update 4 times and then halt until requested to update
        if numberOfUpdates < 4 {
            updateMap()
            numberOfUpdates += 1
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func updateMap() {
        let region = MKCoordinateRegionMakeWithDistance(locationManager.location!.coordinate, 400, 400)
        mapView.setRegion(region, animated: true)
    }

}
