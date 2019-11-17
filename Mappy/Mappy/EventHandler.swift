//
//  EventHandler.swift
//  Mappy
//
//  Created by Emil Persson on 2019-11-16.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import Foundation
import MapKit

class EventHandler {
    static let instance = EventHandler()
    
    var allEvents: [Event] = [
        Event(title: "This is an event", location: "Jönköping", description: "Local event", coordinates: CLLocationCoordinate2D(latitude: 57.7826, longitude: 14.1618)),
        Event(title: "Mappy Launch", location: "Jönköping", description: "The launch of the Mappy app", coordinates: CLLocationCoordinate2D(latitude: 57.78, longitude: 14.16))
    ]
    
    func insertNewEvent(newEvent: Event){
        allEvents.append(newEvent)
    }
    
    func updateMap(mapView: MKMapView){
        mapView.addAnnotation(allEvents[allEvents.endIndex-1])
    }
}
