//
//  ViewController.swift
//  mapTest
//
//  Created by Michiel Everts on 01-11-17.
//  Copyright © 2017 Michiel Everts. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    //outlets and variables
    @IBOutlet weak var mapView: MKMapView!
    var diveSites: [DiveSiteProperties] = []
    var diveItem: DiveSiteProperties?
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set location manager to self because this will delegate the the information from your map to itself
        locationManager.delegate = self
        // set the location manager to ask Authorization
        self.locationManager.requestWhenInUseAuthorization()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.notifyObservers),
                                               name:  NSNotification.Name(rawValue: NotificationID.getDataID ),
                                               object: nil)
        
//A) set tap gesture to recognize the touchpoint as a location on the mapView
//B) convert touchedLocation to coordinates in your mapView
//C) object u create in wich u store set properties as annotation wich u can later connect with the converted coordinates of your touched point in the mapView
//D) dropped pin a title and connect it with with the var that stores coordinates

    }
    @IBAction func longTapGesture(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else {return}
        let touchPoint = sender.location(in: self.mapView)// A
        let touchedCoord = mapView.convert(touchPoint, toCoordinateFrom: mapView)//B
        let droppedPin = MKPointAnnotation()//C
        
        droppedPin.title = "Dropped Pin"//D
        droppedPin.coordinate = touchedCoord//D
        let dropppedPinView = MKAnnotationView.init(annotation: droppedPin, reuseIdentifier: "Pin")//?
        dropppedPinView.tintColor = UIColor.blue
        self.mapView.addAnnotation(dropppedPinView.annotation!)
    }
// func in wich u set the initial zoom radius, else the radius is random(too out r in zoomed)
// A) set the delegate of mapView to self so that all the information recieved and passed are stored and send on the same View
// B) here u set the radius of how wide u want u the initial room radius to be
// C)
    func setInitialZoomLocation(location: CLLocationCoordinate2D) {
        mapView.delegate = self//A
        let regionRadius: CLLocationDistance = 12500//B
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//A) call func to set map in the observer func
    @objc func notifyObservers(notification: NSNotification) {
        var diveSiteDict = notification.userInfo as! Dictionary<String,Any>
        if let  diveSiteArray = diveSiteDict[KeyID.diveSiteID] as? [DiveSiteProperties] {
            setUpMap(diveSiteArray: diveSiteArray)//A
        }
    }
// func to set up map, as parameters use the array of diveSiteProperties u stored in your propertie class
// A) create a var that stores all diveMapAnn properties that u init inside that class into an empy Array
// B) write a for loop to loop through the Array to get all the initiated properties from your annotation class inside your viewController and init their values
// C) append values u set in the viewController to the empty Array
// D) set the map to show all annotations u get back from the database in coordinates in your mapView
    func setUpMap(diveSiteArray: [DiveSiteProperties] ) {
        var annotations:[DiveMapAnnotation] = []//A
        for diveSite in diveSiteArray {
//            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D.init(latitude: diveSite.lat , longitude: diveSite.lng)//B
            let annotation = DiveMapAnnotation.init(diveSite: diveSite, coordinate: coordinate)//B
            annotation.title = diveSite.name//B
            
            annotations.append(annotation) //C
        }
        self.mapView.showAnnotations(annotations, animated: true)//D
        
    }
// func that converts the data from the touch gesture into an actual annotation on your mapView in here you can customize the pin, give the pin func example: if u click the pin it opens a subView/detailView.
// canShowCallout = true calls up a bubble in wich it display's the title and subtitle, if set, of the annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "pinID")
        pinView.canShowCallout = true
        pinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        pinView.animatesDrop = true
        pinView.pinTintColor = UIColor.red
        pinView.image = #imageLiteral(resourceName: "fever-wild-west-pin-up-kostuum")
        return pinView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
}



