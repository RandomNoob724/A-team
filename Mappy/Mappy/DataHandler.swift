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
            "latitude": event.coordinate.latitude,
            "longitude": event.coordinate.longitude,
            "eventId" : "sakd"
        ]) { err in
            if let err = err {
                print("error adding to database: \(err)")
            } else {
                print("event added with ID: \(ref!.documentID)")
            }
        }
    }
     
    func readEvents(completion:((Array<Event>)-> Void)?) {
    
        var listOfEvents: [Event] = []
        
        db.collection("events").getDocuments() { (querySnapshot,err) in
            if let err = err {
                print("error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    listOfEvents.append(Event(
                       title: document.data()["title"] as? String ?? "title",
                       location: document.data()["location"] as? String ?? "location",
                       description: document.data()["eventDescription"] as? String ?? "eventDescription",
                       coordinates: CLLocationCoordinate2D(
                           latitude: document.data()["latitude"] as? CLLocationDegrees ?? CLLocationDegrees(signOf: 0.0,magnitudeOf: 0.0),
                           longitude: document.data()["longitude"] as? CLLocationDegrees ?? CLLocationDegrees(signOf: 0.0,magnitudeOf: 0.0)
                       ),
                       eventId: document.documentID
                   ))
                }
                completion?(listOfEvents)
            }
        }
    }
}






