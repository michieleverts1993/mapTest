//
//  mapDiveSiteService.swift
//  mapTest
//
//  Created by Michiel Everts on 01-11-17.
//  Copyright © 2017 Michiel Everts. All rights reserved.
//whats up

import Foundation
import Alamofire

    class mapDiveSiteService {
        public static let sharedInstance = mapDiveSiteService()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
        
        private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    }
        
        func diveSearchDtail(id: String){
            //http://api.divesites.com/?mode=detail&siteid=17559
    }
        
// func that calls up the api, converts the data, u declare, and puts it into an array so that u can use it
        func getDiveSiteAPI(lat: Double, lng: Double, dist: Int) {
            Alamofire.request("http://api.divesites.com/?mode=sites&lat=\(lat)&lng=\(lng)&dist=\(25)").responseJSON { (jsonData)
                in
                var itemArray:[DiveSiteProperties] = []
                if let json = jsonData.result.value as? NSDictionary,
                    let sites = json["sites"] as? NSArray {
                    for dict in sites {
                        if let unwrappedDict = dict as? NSDictionary {
                            if let name = unwrappedDict["name"] as? String,
                                let id = unwrappedDict["id"] as? String,
                                let lng = unwrappedDict["lng"] as? String,
                                let lat = unwrappedDict["lat"] as? String{
                                let diveSites = DiveSiteProperties.init(name: name, id: id, lng: Double(lng)!, lat: Double(lat)!)
                                itemArray.append(diveSites)
                                print(itemArray)
                            }
                        }
                    }
// sets up the radio with wich your app can communicate with, i.e. with wich it can pick up the data
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationID.getDataID),
                                                                                    object: self,
                                                                                    userInfo: [KeyID.diveSiteID:
                                                                                    itemArray])
            }
        }
    }
}
