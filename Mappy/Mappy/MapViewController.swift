//
//  MapViewController.swift
//  Mappy
//
//  Created by Emil Persson on 2019-11-15.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checks location services
        checkLocationServices()
        mapView.delegate = self
        
        //starts updating the users location
        locationManager.startUpdatingLocation()
        
        //Sets initial location to the users location
        let initialLocation = locationManager.location
        centerMapOnLocation(location: initialLocation ?? CLLocation(latitude: 57.78, longitude: 14.16))
        
        //Fetches events from the firestore database and ads them into the eventhandler.instance.allEvents
        //adds every annotation onto the map
        DataHandler.instance.readEvents(completion: { loadedEvents in
            EventHandler.instance.allEvents = loadedEvents
            self.mapView.addAnnotations(EventHandler.instance.allEvents)
        })
    }
    
    //MARK: LONG TUOCH HAPPENED
    //When the user holds down the touch for a longer time they will be prompted to a modal view where they can create new events through a form
    @IBAction func longTouchHappened(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let position = sender.location(in: self.mapView)
            let newCoordinate = self.mapView.convert(position, toCoordinateFrom: self.mapView)
            performSegue(withIdentifier: "CreateNewEvent", sender: newCoordinate)
        }
    }
    
    //MARK: PRESSED FETCH BUTTON
    @IBAction func fetchEventButton(_ sender: Any) {
        DataHandler.instance.readEvents(completion: { loadedEvents in
            self.mapView.removeAnnotations(EventHandler.instance.allEvents)
            EventHandler.instance.allEvents = loadedEvents
            self.mapView.addAnnotations(EventHandler.instance.allEvents)
        })
    }
    
    //MARK: CENTER BUTTON PRESSED
    @IBAction func centerOnUserLocation(_ sender: Any) {
        let userPosition = mapView.userLocation.coordinate
        centerMapOnLocation(location: CLLocation(latitude: userPosition.latitude, longitude: userPosition.longitude))
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.addAnnotations(EventHandler.instance.allEvents)
    }
    
    //MARK:CHECK LOCATION SERVICES
    //Method for calling the checkLocationAuthorization method
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            checkLocationAuthorization()
        } else {
            print("User did not want to show location")
        }
    }
    
    //MARK: CHECK LOCATION AUTH
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
    
    //MARK: CENTER MAP ON LOCATION
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
            destinationViewController?.mapView = mapView
            destinationViewController?.eventCoordinates = sender as? CLLocationCoordinate2D
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    //MARK: CREATE ANNOTATION
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
    
    //MARK: PRESSED INFO BUTTON
    //When information is clicked on the annotation the user is taken to the apple maps app where you can find more specific information how to get to a specific point
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl){
        let selectedEvent = view.annotation as! Event
        performSegue(withIdentifier: "DetailedEvent", sender: selectedEvent)
    }
}
