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
        if status == .authorizedAlways || status == .authorizedWhenInUse { //This is where we ask for authorisation from the user
            self.locationManager.requestLocation()
        }
    }
// func that updates the location u last tapped or scrolled too ?
    //This called when the location is received from the location manager, it takes a few seconds to get it - B
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //At this point when we have the user location we can request dive sites surrounding it.. -B
            mapDiveSiteService.sharedInstance.getDiveSiteAPI(lat: location.coordinate.latitude, lng: location.coordinate.longitude, dist: 25)
            //tell it to stop polling for location as this is expensive operation - B
            self.locationManager.stopUpdatingLocation()
        }
    }
// func that print a message if the location manager  can not find where the person/phone is - B
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

