//
//  DetailedEventViewController.swift
//  Mappy
//
//  Created by Emil Persson on 2019-11-16.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit
import MapKit

class DetailedEventViewController: UIViewController {
    
    @IBOutlet weak var detailedViewHeader: UILabel!
    @IBOutlet weak var detailedViewDescription: UILabel!
    @IBOutlet weak var detailedViewDate: UILabel!
    @IBOutlet weak var detailedViewTime: UILabel!
    @IBOutlet weak var detailedViewOwner: UILabel!
    
    var selectedEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailedViewHeader.text = selectedEvent?.title
        detailedViewDescription.text = selectedEvent?.eventDescription
        detailedViewDate.text = selectedEvent?.date
        detailedViewTime.text = selectedEvent?.time
        detailedViewOwner.text = selectedEvent?.owner
    }
    
    //MARK: PRESSED GET THERE BUTTON
    @IBAction func getThereClicked(_ sender: Any) {
        //When clicked you want to segue over to the detailed Event view such that we can display the detailed information abou the event
        let location = selectedEvent
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        location?.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    //MARK: PRESSED CLOSE BUTTON
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
