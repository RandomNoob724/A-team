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
    var locationName: String
    var date: String
    var time: String
    var eventDescription: String

    
    private let locationManager = CLLocationManager()
    
    let geocoder = CLGeocoder()
    
    init(title: String = "PlaceHolder", location: String = "No location name", description: String = "This is an event to celebrate the null point", coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0), date: String = "No set date", time: String = "No set time") {
        self.title = title
        self.eventDescription = description
        self.coordinate = coordinates
        self.locationName = location
        self.date = date
        self.time = time
        super.init()
    }
    
    func setTitle(newTitle: String){
        self.title = newTitle
    }
    
    func setLocation(coordinates: CLLocationCoordinate2D){
        self.locationManager.getPlace(for: CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { placemark in
            guard let placemark = placemark else { return }
            
            if placemark.country != nil {
                self.locationName = "\(placemark.country!)"
            }
            if placemark.administrativeArea != nil{
                self.locationName += ", \(placemark.administrativeArea!)"
            }
            if placemark.locality != nil {
                self.locationName += ", \(placemark.locality!)"
            }
        }
    }
    
    func updateCoordinates(newCoordinates: CLLocationCoordinate2D){
        self.coordinate = newCoordinates
    }
    
    var subtitle: String?{
        return self.locationName
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
        geocoder.reverseGeocodeLocation(location){ (placemarks, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                completion(nil)
                return
            }
            completion(placemark)
        }
    }
}
