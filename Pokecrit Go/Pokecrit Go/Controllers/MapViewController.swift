//
//  MapViewController.swift
//  Pokecrit Go
//
//  Created by Dulio Denis on 5/5/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var numberOfUpdates = 0
    
    var pokecrits: [Pokecrit] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.delegate = self
        
        pokecrits = getAllPokecrits()
        
        // if we are authorized to show location - display it
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            
            // start a timer for the critter spawn
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                if let coordinate = self.locationManager.location?.coordinate {
                    let randomPokecrit = self.pokecrits[Int(arc4random_uniform(UInt32(self.pokecrits.count)))]
                    let annotation = PokecritAnnotation(coordinate: coordinate, pokecrit: randomPokecrit)

                    // Randomize the location of spawn
                    annotation.coordinate.latitude  += (Double(arc4random_uniform(1000)) - 500) / 300000.0
                    annotation.coordinate.longitude += (Double(arc4random_uniform(1000)) - 500) / 300000.0
                    self.mapView.addAnnotation(annotation)
                }
            })
        } else {
            // otherwise request it
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // MARK: - Update User Location
    
    @IBAction func updateLocation(_ sender: Any) {
        updateMap()
    }

}


// MARK: - Location Manager Delegate Method

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // update 4 times and then halt until requested to update
        if numberOfUpdates < 4 {
            updateMap()
            numberOfUpdates += 1
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
}


// MARK: - Map View Delegate Methods

extension MapViewController: MKMapViewDelegate {
    
    func updateMap() {
        let region = MKCoordinateRegionMakeWithDistance(locationManager.location!.coordinate, 400, 400)
        mapView.setRegion(region, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        
        // ignore the user
        if view.annotation! is MKUserLocation {
            return
        }
        
        // establish a tighter capture region
        let region = MKCoordinateRegionMakeWithDistance(view.annotation!.coordinate, 150, 150)
        mapView.setRegion(region, animated: false)
        
        if let coordinate = locationManager.location?.coordinate {
            let ann = view.annotation as! PokecritAnnotation
            if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coordinate)) {
                print("Capture \(ann.pokecrit.name!).")
                let battle = BattleViewController()
                battle.pokecrit = ann.pokecrit
                present(battle, animated: true)
            } else {
                print("Too far to capture \(ann.pokecrit.name!).")
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            annotationView.image = UIImage(named: "pin")
        } else {
            let pokecrit = (annotation as! PokecritAnnotation).pokecrit
            annotationView.image = UIImage(named: pokecrit.imageURL!)
        }
        
        var newFrame = annotationView.frame
        newFrame.size.height = 40
        newFrame.size.width = 40
        annotationView.frame = newFrame
        
        return annotationView
    }
    
}
