//
//  locationManager.swift
//  mapTest
//
//  Created by Michiel Everts on 01-11-17.
//  Copyright © 2017 Michiel Everts. All rights reserved.
//

import Foundation
import CoreLocation

extension ViewController:  CLLocationManagerDelegate {
    
    
// func that sets the initial qeustion for the authorization of the app to ask u if u want it to find your location
// ?? why this if statement
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse { //?
            self.locationManager.requestLocation()
        }
    }
// func that updates the location u last tapped or scrolled too ?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            mapDiveSiteService.sharedInstance.getDiveSiteAPI(lat: location.coordinate.latitude, lng: location.coordinate.longitude, dist: 25)
            
            self.locationManager.stopUpdatingLocation()
        }
    }
// func that print a message if the database or app can not find a location of some other rror
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

