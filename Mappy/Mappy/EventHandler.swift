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
    //MARK: INSERT NEW EVENT
    func insertNewEvent(newEvent: Event){
        newEvent.setLocation(coordinates: newEvent.coordinate)
        allEvents.append(newEvent)
    }
    //MARK: UPDATE MAP
    func updateMap(mapView: MKMapView){
        mapView.addAnnotation(allEvents[allEvents.endIndex-1])
    }
}

