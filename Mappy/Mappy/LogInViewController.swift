//
//  LogInViewController.swift
//  Mappy
//
//  Created by Axel Dalbard on 2019-11-28.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    @IBAction func GoBackHome(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        self.EmailTextField.inputAccessoryView = toolBar
        self.PasswordTextField.inputAccessoryView = toolBar

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        //AVAILABLE ACCOUNTS
        //email: mrgabbeshi@gmail.com   pw: hej123
        //email: axeldalbard@hotmail.com   pw:hello123
        UserHandler.instance.login(withEmail: EmailTextField.text!, password: PasswordTextField.text!, ((Error?)->(Void))?{error in
            if(error == nil){
                self.performSegue(withIdentifier: "loginToMap", sender: self)
            } else{
                let errorCode = (error! as NSError).code
                
                switch errorCode {
                case 17008:
                    self.ErrorLabel.text = "Invalid E-Mail"
                case 17009:
                    self.ErrorLabel.text = "Invalid password"
                case 17011:
                    self.ErrorLabel.text = "User not found"
                default:
                    self.ErrorLabel.text = "Something went wrong"
                    print(errorCode)
                }
            }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    @objc func onClickDoneButton()
    {
        self.view.endEditing(true)
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
