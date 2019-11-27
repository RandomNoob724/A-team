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
    //MARK: ADD EVENT
    func addEvent(event: Event){
        var ref: DocumentReference? = nil
        ref = db.collection("events").addDocument(data: [
            "title"             : event.title ?? "eventTitle",
            "eventDescription"  : event.eventDescription,
            "location"          : event.location,
            "latitude"          : event.coordinate.latitude,
            "longitude"         : event.coordinate.longitude,
            "date"              : event.date,
            "time"              : event.time
        ]) { err in
            if let err = err {
                print("error adding to database: \(err)")
            } else {
                print("event added with ID: \(ref!.documentID)")
            }
        }
    }
    
    //MARK: READ EVENT
    func readEvents(completion:((Array<Event>)-> Void)?) {
    
        var listOfEvents: [Event] = []
        
        db.collection("events").getDocuments() { (querySnapshot,err) in
            if let err = err {
                print("error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let eventObj = Event(
                        title: document.data()["title"] as? String ?? "title",
                        description: document.data()["eventDescription"] as? String ?? "eventDescription",
                        coordinates: CLLocationCoordinate2D(
                            latitude: document.data()["latitude"] as? CLLocationDegrees ?? CLLocationDegrees(signOf: 0.0,magnitudeOf: 0.0),
                            longitude: document.data()["longitude"] as? CLLocationDegrees ?? CLLocationDegrees(signOf: 0.0,magnitudeOf: 0.0)
                        
                    ))
                    eventObj.setLocation(coordinates: eventObj.coordinate)
                    listOfEvents.append(eventObj)
                }
                completion?(listOfEvents)
            }
        }
    }
    
    //MARK: DELETE EVENT
    func deleteEvent(id:String) {
        db.collection("events").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
