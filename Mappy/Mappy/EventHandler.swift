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
    
    var allEvents: [Event] = []
    
    func insertNewEvent(newEvent: Event, mapView: MKMapView){
        newEvent.setLocation(coordinates: newEvent.coordinate)
        allEvents.append(newEvent)
        updateMap(mapView: mapView)
    }
    
    func updateMap(mapView: MKMapView){
        mapView.addAnnotation(allEvents[allEvents.endIndex-1])
    }
}

