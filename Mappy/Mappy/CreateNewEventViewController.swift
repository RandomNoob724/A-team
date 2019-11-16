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
    
    var eventPosition: CLLocationCoordinate2D!
    
    @IBAction func createNewEventButtonClicked(_ sender: Any) {
        
    }
    
//    func createNewEventOnPosition(eventCoordinates: CLLocationCoordinate2D) -> Event {
//        guard let title = eventTitle.text else {return nil}
//        guard let location = eventLocation.text else {return nil}
//        let newEvent = Event(title: title, location: location, description: "Placeholder", coordinates: eventPosition)
//        return newEvent
//    }
    
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
