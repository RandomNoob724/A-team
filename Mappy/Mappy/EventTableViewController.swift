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
    //Segue to Create new Event
    @IBAction func showCreateNewEventController(_ sender: Any)
    {
        self.performSegue(withIdentifier: "createNewEventSegue", sender: self)
    }
    
    //Finds users location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {

        let location = locations.last! as CLLocation

        newCoordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

    }

    
    //Segue to detailed event controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToDetailedEvent", sender: EventHandler.instance.allEvents[indexPath.row])
    }
    
    //Passes necessary data destination
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

    //Counts amount of cells in tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return EventHandler.instance.allEvents.count
    }
    
    //Sets the cells up with title, date and time
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

    //Refresh tableview
    @IBAction func refreshTableViewController(_ sender: UIRefreshControl)
    {
        tableView.reloadData()
        sender.endRefreshing()
    }
    

}
