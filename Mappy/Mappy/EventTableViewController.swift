//
//  EventTableViewController.swift
//  Mappy
//
//  Created by Emil Persson on 2019-11-17.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EventTableViewController: UITableViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var newCoordinates: CLLocationCoordinate2D!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showCreateNewEventController(_ sender: Any)
    {
        performSegue(withIdentifier: "createNewEventSegue", sender: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {

        let location = locations.last! as CLLocation

        newCoordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? CreateNewEventViewController
        destination?.eventCoordinates = newCoordinates
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
