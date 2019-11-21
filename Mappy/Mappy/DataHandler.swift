//
//  DataHandler.swift
//  Mappy
//
//  Created by gabriel brickman hildingsson on 2019-11-21.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class DataHandler{
    
    static let instance = DataHandler()
    let db = Firestore.firestore()
    func addEvent(event: Event){
        
        var ref: DocumentReference? = nil
        ref = db.collection("events").addDocument(data: [
            "title" : event.title ?? "eventTitle",
            "eventDescription" : event.eventDescription,
            "location" : event.location,
            "coordinates" :  GeoPoint(latitude: event.coordinate.latitude,longitude: event.coordinate.longitude)
        ]) { err in
            if let err = err {
                print("error adding to database: \(err)")
            } else {
                print("event added with ID: \(ref!.documentID)")
            }
        }
    }
}
