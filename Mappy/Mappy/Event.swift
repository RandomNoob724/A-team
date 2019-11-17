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
import CoreLocation

class Event: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var location: String
    var eventDescription: String
    
    private let locationManager = CLLocationManager()
    
    let geocoder = CLGeocoder()
    
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
    
    func setLocation(coordinates: CLLocationCoordinate2D){
        self.locationManager.getPlace(for: CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { placemark in
            guard let placemark = placemark else { return }
            self.location = "\(placemark.country!), \(placemark.administrativeArea!), \(placemark.locality!)"
        }
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

//MARK: - Get Placemark
extension CLLocationManager {
    func getPlace(for location:CLLocation, completion: @escaping (CLPlacemark?) -> Void){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location){ placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("***Error in \(#function) : placemark is nil")
                completion(nil)
                return
            }
            completion(placemark)
        }
    }
}
