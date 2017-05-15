//
//  PokecritAnnotation.swift
//  Pokecrit Go
//
//  Created by Dulio Denis on 5/14/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit
import MapKit


class PokecritAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokecrit: Pokecrit
    
    init(coordinate: CLLocationCoordinate2D, pokecrit: Pokecrit) {
        self.coordinate = coordinate
        self.pokecrit = pokecrit
    }

}
