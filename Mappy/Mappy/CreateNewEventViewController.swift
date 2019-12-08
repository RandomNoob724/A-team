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
    

    
    var eventCoordinates: CLLocationCoordinate2D!
    var datePicker: UIDatePicker?
    var timePicker: UIDatePicker?
    
    var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - TextField and keyboard setup.
        //Setup the date textfield as a datepicker.
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
        
        //Adds toolbar to all inputfields.
        self.eventDate.inputAccessoryView = toolBar
        self.eventTime.inputAccessoryView = toolBar
        self.eventDescription.inputAccessoryView = toolBar
        self.eventTitle.inputAccessoryView = toolBar
        
        //Set a black border to the description field
        self.eventDescription.layer.borderWidth = 1
        self.eventDescription.layer.borderColor = UIColor.black.cgColor

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: - Create Button clicked.
    @IBAction func createNewEventButtonClicked(_ sender: UIButton) {
        guard let title = eventTitle.text else {return}
        guard let date = self.eventDate.text else {return}
        guard let time = self.eventTime.text else {return}
        guard let description = self.eventDescription.text else {return}
        guard let owner = UserHandler.instance.user?.email else {return}
        let newEvent = Event(title: title, description: description, coordinates: eventCoordinates, date: date, time: time,owner: owner)
        DataHandler.instance.addEvent(event: newEvent)
        EventHandler.instance.insertNewEvent(newEvent: newEvent)
        if mapView != nil{
            EventHandler.instance.updateMap(mapView: mapView)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Textfield and keyboard methods
    //Handles the date format and puts the desired date in the date TextField.
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM-yyyy"
        self.eventDate.text = dateFormatter.string(from: datePicker.date)
    }
      
    //Handles the time format and puts the desired time in the time TextField.
    @objc func timeChanged(timePicker: UIDatePicker){
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        self.eventTime.text = timeFormatter.string(from: timePicker.date)
    }
       
    //Handles the toolbar button (Done) click so the UIDatePicker is dismissed.
    @objc func onClickDoneButton(){
        self.view.endEditing(true)
    }
    
    //Handles the button (Back) click so the UIViewController is dismissed.
    @IBAction func dismissViewController(_ sender: Any){
        self.dismiss(animated: true, completion:{
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })
    }

    //The whole view gets pushed up equal to the keyboard height when the description text view is selected.
    @objc func keyboardWillShow(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.eventDescription.isFirstResponder{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    //Pushes down the view when the keyboard is dismissed
    @objc func keyboardWillHide(notification: Notification){
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
}
