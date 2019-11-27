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
    
    @IBOutlet var eventTableView: UITableView!
    
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
        eventTableView.reloadData()
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

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "segueToDetailedEvent", sender: EventHandler.instance.allEvents[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewEventSegue"
        {
            let destination = segue.destination as? CreateNewEventViewController
            destination?.eventCoordinates = newCoordinates
        }
        else if segue.identifier == "segueToDetailedEvent"
        {
            let destination = segue.destination as? DetailedEventViewController
            destination?.selectedEvent = sender as? Event
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return EventHandler.instance.allEvents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell
        {
            let event = EventHandler.instance.allEvents[indexPath.row]
            cell.titleForEvent.text = event.title
            cell.dateForEvent.text = event.date
            cell.timeForEvent.text = event.time
            
            return cell
        }
        return UITableViewCell()
    }

    @IBAction func refreshTableViewController(_ sender: UIRefreshControl)
    {
        tableView.reloadData()
        sender.endRefreshing()
    }
    

}
