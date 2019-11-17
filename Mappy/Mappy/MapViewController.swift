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
    
    //When the user holds down the touch for a longer time they will be prompted to a modal view where they can create new events through a form
    @IBAction func longTouchHappened(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let position = sender.location(in: self.mapView)
            let newCoordinate = self.mapView.convert(position, toCoordinateFrom: self.mapView)
            performSegue(withIdentifier: "CreateNewEvent", sender: newCoordinate)
        }
    }
    
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
        centerMapOnLocation(location: initialLocation)
        //Fills the list with 100 random locations around the world
        for i in 0..<100{
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(Float.random(in: 0..<90)), longitude: CLLocationDegrees(Float.random(in: 0..<180)))
            EventHandler.instance.insertNewEvent(newEvent: Event(coordinates: location))
            print(EventHandler.instance.allEvents[i].location)
        }
        for i in EventHandler.instance.allEvents {
            i.setLocation(coordinates: i.coordinate)
            print(i.location)
            mapView.addAnnotation(i)
        }
    }
    
    //Method for calling the checkLocationAuthorizat ion method
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedEvent" {
            let destinationViewController = segue.destination as? DetailedEventViewController
            destinationViewController?.selectedEvent = sender as? Event
        } else if segue.identifier == "CreateNewEvent" {
            let destinationViewController = segue.destination as? CreateNewEventViewController
            destinationViewController?.eventCoordinates = sender as? CLLocationCoordinate2D
        }
    }
}

//Creates new mapViewDelegate
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
            view.markerTintColor = UIColor.systemGreen
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
