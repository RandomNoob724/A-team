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
    @IBOutlet weak var detailedViewImage: UIImageView!
    @IBOutlet weak var detailedViewDescription: UILabel!
    
    var selectedEvent: Event?
    
    @IBAction func getThereClicked(_ sender: Any) {
        //When clicked you want to segue over to the detailed Event view such that we can display the detailed information abou the event
        let location = selectedEvent
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        location?.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailedViewHeader.text = selectedEvent?.title
        detailedViewDescription.text = selectedEvent?.eventDescription
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
