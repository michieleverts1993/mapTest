//
//  DiveMapAnnotation.swift
//  mapTest
//
//  Created by Michiel Everts on 01-11-17.
//  Copyright © 2017 Michiel Everts. All rights reserved.
//

import Foundation
import MapKit

class DiveMapAnnotation: NSObject, MKAnnotation  {
    var diveSite: DiveSiteProperties
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    
    init(diveSite: DiveSiteProperties, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.diveSite = diveSite
    }
}
