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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        
        UserHandler.instance.login(withEmail: "mrgabbeshigmail.com", password: "hej123", ((Error?)->(Void))?{error in
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
                    self.ErrorLabel.text = "Sum ting went wong"
                }
            }
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
