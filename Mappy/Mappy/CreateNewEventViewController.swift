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
    @IBOutlet weak var eventDate: UITextField!
    @IBOutlet weak var eventTime: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    
    @IBOutlet weak var eventLocation: UITextField!
    
    var eventCoordinates: CLLocationCoordinate2D!
    var datePicker: UIDatePicker?
    var timePicker: UIDatePicker?
    
    var mapView: MKMapView!
    
    @IBAction func createNewEventButtonClicked(_ sender: UIButton) {
        guard let title = eventTitle.text else {return}
        guard let locationName = eventLocation.text else {return}
        guard let date = self.eventDate.text else {return}
        guard let time = self.eventTime.text else {return}
        guard let description = self.eventDescription.text else {return}
        let newEvent = Event(title: title, location: locationName, description: description, coordinates: eventCoordinates, date: date, time: time)
        DataHandler.instance.addEvent(event: newEvent)
        EventHandler.instance.insertNewEvent(newEvent: newEvent)
        if mapView != nil{
            EventHandler.instance.updateMap(mapView: mapView)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.datePicker = UIDatePicker()
        self.datePicker?.datePickerMode = .date
        self.datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        self.eventDate.inputView = datePicker
        
        //Setup the time textfield a timepicker.
        self.timePicker = UIDatePicker()
        self.timePicker?.datePickerMode = .time
        self.timePicker?.locale = Locale(identifier: "en_GB")
        self.timePicker?.addTarget(self, action: #selector(timeChanged(timePicker:)), for: .valueChanged)
        self.eventTime.inputView = timePicker
        
        //Setup the toolbar for the UIDatePicker.
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        //Add the toolbar to the time and datepickers
        self.eventDate.inputAccessoryView = toolBar
        self.eventTime.inputAccessoryView = toolBar
        
        //Set a black border to the description field
        self.eventDescription.layer.borderWidth = 1
        self.eventDescription.layer.borderColor = UIColor.black.cgColor

        // Do any additional setup after loading the view.
    }
    
    //Handles the date format and puts the desired date in the date TextField.
       @objc func dateChanged(datePicker: UIDatePicker)
       {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MMM-yyyy"
           self.eventDate.text = dateFormatter.string(from: datePicker.date)
       }
       
       //Handles the time format and puts the desired time in the time TextField.
       @objc func timeChanged(timePicker: UIDatePicker)
       {
           let timeFormatter = DateFormatter()
           timeFormatter.dateFormat = "hh:mm"
           self.eventTime.text = timeFormatter.string(from: timePicker.date)
       }
       
       //Handles the toolbar button (Done) click so the UIDatePicker is dismissed.
       @objc func onClickDoneButton()
       {
           self.view.endEditing(true)
       }
       
       //Handles the button (Back) click so the UIViewController is dismissed.
       @IBAction func dismissViewController(_ sender: Any)
       {
           self.dismiss(animated: true, completion:
           {
               self.presentingViewController?.dismiss(animated: true, completion: nil)
           })
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
