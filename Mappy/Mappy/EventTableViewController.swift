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
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        eventTableView.reloadData()
    }
    //MARK: SEGUE TO CREATE NEW EVENT
    @IBAction func showCreateNewEventController(_ sender: Any){
        self.performSegue(withIdentifier: "createNewEventSegue", sender: self)
    }
    
    //MARK: FINDS USERS LOCAITON
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

        let location = locations.last! as CLLocation

        newCoordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }

    //MARK: SEGUE TO DETAILED EVENT CONTROLLER
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToDetailedEvent", sender: EventHandler.instance.allEvents[indexPath.row])
    }
    
    //MARK: PASSES DATA
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewEventSegue"{
            let destination = segue.destination as? CreateNewEventViewController
            destination?.eventCoordinates = newCoordinates
        }else if segue.identifier == "segueToDetailedEvent"{
            let destination = segue.destination as? DetailedEventViewController
            destination?.selectedEvent = sender as? Event
        }
    }
    
    //MARK: NUMBER OF CELLS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return EventHandler.instance.allEvents.count
    }
    
    //MARK: SETS UP THE CELLS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell{
            let event = EventHandler.instance.allEvents[indexPath.row]
            cell.titleForEvent.text = event.title
            cell.dateForEvent.text = event.date
            cell.timeForEvent.text = event.time
            
            return cell
        }
        return UITableViewCell()
    }

    //MARK: REFRESH TABLEVIEW
    @IBAction func refreshTableViewController(_ sender: UIRefreshControl){
        DataHandler.instance.readEvents(completion: {updatedEvents in
            EventHandler.instance.allEvents = updatedEvents
            sender.endRefreshing()
        })
        tableView.reloadData()
    }
}
