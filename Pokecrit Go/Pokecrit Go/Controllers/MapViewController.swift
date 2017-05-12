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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        // if we are authorized to show location - display it
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            // otherwise request it
            locationManager.requestWhenInUseAuthorization()
        }
    }

}
