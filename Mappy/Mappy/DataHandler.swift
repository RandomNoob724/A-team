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
    
    private var screenWidth: Int = 1000
    private var screenHeigth: Int = 1000
    
    private var homepageBackgroundImage: BackgroundImage?
    
    //MARK: SET SCREEN SIZE
    func setScreenWidth(width: Int){
        self.screenWidth = width
    }
    
    func setScreenHeigth(heigth: Int){
        self.screenHeigth = heigth
    }
    
    //MARK: SET BACKGROUND IMAGE
    func setBackgroundImage(backgroundImage: BackgroundImage){
        homepageBackgroundImage = backgroundImage
        homepageBackgroundImage!.download_url = "https://picsum.photos/id/\(homepageBackgroundImage!.id)/\(screenWidth)/\(screenHeigth)"
    }
    //MARK: GET IMAGE
    func getImageUrl() -> URL?{
        if let url = homepageBackgroundImage?.download_url {
            return URL(string: url)
        }
        return nil
    }
    
    //MARK: ADD EVENT
    func addEvent(event: Event){
        var ref: DocumentReference? = nil
        ref = db.collection("events").addDocument(data: [
            "title"             : event.title ?? "eventTitle",
            "eventDescription"  : event.eventDescription,
            "latitude"          : event.coordinate.latitude,
            "longitude"         : event.coordinate.longitude,
            "date"              : event.date,
            "time"              : event.time,
            "owner"             : event.owner
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
                        title           : document.data()["title"] as? String ?? "title",
                        description     : document.data()["eventDescription"] as? String ?? "eventDescription",
                        coordinates     : CLLocationCoordinate2D(
                            latitude    : document.data()["latitude"] as? CLLocationDegrees ?? CLLocationDegrees(signOf: 0.0,magnitudeOf: 0.0),
                            longitude   : document.data()["longitude"] as? CLLocationDegrees ?? CLLocationDegrees(signOf: 0.0,magnitudeOf: 0.0)
                        
                        ),
                        eventId         : document.documentID,
                        date            : document.data()["date"] as? String ?? "no set date",
                        time            : document.data()["time"] as? String ?? "no set time",
                        owner           : document.data()["owner"] as? String ?? "no owner"
                    )
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
