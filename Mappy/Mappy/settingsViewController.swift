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

        // Do any additional setup after loading the view.
    }

    
    @IBAction func pressedLogOutButton(_ sender: UIButton) {
        if UserHandler.instance.signOut(){
            
        } else {
            errorLabel.text = "Something went wrong"
        }
    }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
