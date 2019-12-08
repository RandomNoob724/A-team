//
//  SignUpViewController.swift
//  Mappy
//
//  Created by Axel Dalbard on 2019-11-29.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        self.firstNameTextField.inputAccessoryView = toolBar
        self.lastNameTextField.inputAccessoryView = toolBar
        self.emailTextField.inputAccessoryView = toolBar
        self.passwordTextField.inputAccessoryView = toolBar
    }
    //MARK: PRESSED BACK BUTTON
    @IBAction func GoBackHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: PRESSED SIGN UP BUTTON
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        
        UserHandler.instance.createUser(email: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, ((Error?)->(Void))?{error in
            if(error == nil){
                self.performSegue(withIdentifier: "signupToMap", sender: self)
            } else{
                let errorCode = (error! as NSError).code
                
                switch errorCode {
                case 17007:
                    self.errorLabel.text = "E-Mail already in use"
                case 17008:
                    self.errorLabel.text = "Invalid E-Mail"
                case 17034:
                    self.errorLabel.text = "Please enter E-Mail"
                case 17026:
                    if (self.passwordTextField.text == ""){
                        self.errorLabel.text = "Please enter password"
                    } else {
                        self.errorLabel.text = "Weak password"
                    }
                default:
                    self.errorLabel.text = "Something went wrong"
                    print(errorCode)
                }
            }
        })
    }
    
    //MARK: KEYBOARD DISAPPEAR
    //Press somewhere on the View to make the keyboard disappear.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //MARK: PRESSED DONE BUTTON
    //Handles the toolbar button (Done) click so the keyboard is dismissed.
    @objc func onClickDoneButton()
    {
        self.view.endEditing(true)
    }
    
    //MARK: SHOW KEYBOARD
    @objc func keyboardWillShow(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.passwordTextField.isFirstResponder {
                self.view.frame.origin.y -= (keyboardSize.height)/2
            }
        }
    }
    
    //MARK: HIDE KEYBOARD
    @objc func keyboardWillHide(notification: Notification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
