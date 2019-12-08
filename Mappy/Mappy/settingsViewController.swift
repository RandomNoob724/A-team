//
//  settingsViewController.swift
//  Mappy
//
//  Created by Gabriel Hildingsson Brickman on 03/12/19.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: PRESSED LOG IN BUTTON
    @IBAction func pressedLogOutButton(_ sender: UIButton) {
        if UserHandler.instance.signOut(){
            
        } else {
            errorLabel.text = "Something went wrong"
        }
    }
    
    //MARK: PRESSED RESET PASSWORD BUTTON
    @IBAction func pressedResetPasswordButton(_ sender: UIButton) {
        UserHandler.instance.sendPasswordReset(withEmail: (UserHandler.instance.user?.email)!) { (error) in
            if error != nil{
                print(error)
                self.errorLabel.text = "Something went wrong"
            } else {
                self.errorLabel.textColor = UIColor.systemGreen
                self.errorLabel.text = "Check your E-Mail"
            }
        }
    }
}
