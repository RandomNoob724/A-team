//
//  MapViewController.swift
//  Mappy
//
//  Created by Emil Persson on 2019-11-15.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var allEvents: [Event] = []
    
    @IBAction func centerOnUserLocation(_ sender: Any) {
        let userPosition = mapView.userLocation.coordinate
        centerMapOnLocation(location: CLLocation(latitude: userPosition.latitude, longitude: userPosition.longitude))
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        mapView.delegate = self
        //Sets initial location to Jönköping
        //TODO: In the future set the initial location to the users current location
        let initialLocation = CLLocation(latitude: 57.7826, longitude: 14.1618)
//        let mapEvent = Event(title: "This is an event", location: "Jönköping", description: "Local event", coordinates: CLLocationCoordinate2D(latitude: 57.7826, longitude: 14.1618))
//        let otherEvent = Event(title: "Mappy Launch", location: "Jönköping", description: "The launch of the Mappy app", coordinates: CLLocationCoordinate2D(latitude: 57.78, longitude: 14.16))
//        allEvents.append(mapEvent)
//        allEvents.append(otherEvent)
        for event in allEvents {
            addEventPinToMap(eventToAdd: event)
        }
        centerMapOnLocation(location: initialLocation)
    }
    
    //Method for calling the checkLocationAuthorization method
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            checkLocationAuthorization()
        } else {
            print("User did not want to show location")
        }
    }
    
    //Check if the user have authenticated the application to use the current location
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted:
            break
        case .authorizedAlways:
            break
        default:
            mapView.showsUserLocation = false
        }
    }
    
    //Called when you want to center the mapView on a speicfic location
    func centerMapOnLocation(location: CLLocation){
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //Takes an event objects and puts a pin with annotation on the map
    func addEventPinToMap(eventToAdd: Event){
        if eventToAdd.title != nil {
            let annotation = MKPointAnnotation()
            annotation.coordinate = eventToAdd.coordinate
            annotation.title = eventToAdd.title
            mapView.addAnnotation(annotation)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedEvent" {
            let destinationViewController = segue.destination as? DetailedEventViewController
            destinationViewController?.selectedEvent = sender as? Event
        }
    }
}

//Creates a new map view delegate
extension MapViewController: MKMapViewDelegate {
    //Used to make custom mapView annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard let annotation = annotation as? Event else {return nil}
        
        let identifier = "marker"
        
        var view: MKMarkerAnnotationView
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeueView.annotation = annotation
            view = dequeueView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    //When information is clicked on the annotation the user is taken to the apple maps app where you can find more specific information how to get to a specific point
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl){
        let selectedEvent = view.annotation as! Event
        performSegue(withIdentifier: "DetailedEvent", sender: selectedEvent)
    }
}
