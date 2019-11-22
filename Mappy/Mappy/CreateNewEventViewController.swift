//
//  CreateNewEventViewController.swift
//  Mappy
//
//  Created by Emil Persson on 2019-11-16.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit
import MapKit

class CreateNewEventViewController: UIViewController {

    @IBOutlet weak var eventTitle: UITextField!
    
    @IBOutlet weak var eventLocation: UITextField!
    
    var eventCoordinates: CLLocationCoordinate2D!
    
    var mapView: MKMapView!
    
    @IBAction func createNewEventButtonClicked(_ sender: UIButton) {
        guard let title = eventTitle.text else {return}
        let newEvent = Event(title: title, description: "Something random that i do not know what it is", coordinates: eventCoordinates)
        EventHandler.instance.insertNewEvent(newEvent: newEvent, mapView: mapView)
        DataHandler.instance.addEvent(event: newEvent)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
