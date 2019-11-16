//
//  Event.swift
//  Mappy
//
//  Created by Emil Persson on 2019-11-15.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Event: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var location: String
    var eventDescription: String
    
    init(title: String = "PlaceHolder", location: String = "Point Null", description: String = "This is an event to celebrate the null point", coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
        self.title = title
        self.location = location
        self.eventDescription = description
        self.coordinate = coordinates
        super.init()
    }
    
    var subtitle: String?{
        return self.location
    }
    
    func setTitle(newTitle: String){
        self.title = newTitle
    }
    
    func setLocation(newLocation: String){
        self.location = newLocation
    }
    
    func updateCoordinates(newCoordinates: CLLocationCoordinate2D){
        self.coordinate = newCoordinates
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
