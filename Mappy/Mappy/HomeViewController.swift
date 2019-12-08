//
//  HomeViewController.swift
//  Mappy
//
//  Created by Axel Dalbard on 2019-12-02.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataHandler.instance.setScreenWidth(width: Int(self.view.frame.width))
        DataHandler.instance.setScreenHeigth(heigth: Int(self.view.frame.height))
        if let url = DataHandler.instance.getImageUrl() {
            backgroundImageView.kf.setImage(with: url)
        } else {
            fetchBackgroundImage()
        }
        animateHomePage()
    }
    
    func fetchBackgroundImage() {
        RestHandler.fetchImage(completion: { (success) in
            if success, let url = DataHandler.instance.getImageUrl(){
                DispatchQueue.main.async {
                    self.backgroundImageView.kf.setImage(with: url)
                }
            }
            else {
                print("Error!")
            }
        })
    }
    
    func animateHomePage(){
        titleLabel.center.x = self.view.frame.width + 130
        loginButton.center.x = self.view.frame.width + 130
        signupButton.center.x = self.view.frame.width + 130
        
        UIView.animate(withDuration: 2, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 10, options: .curveLinear, animations: {
            self.titleLabel.center.x = self.view.frame.width / 2
            self.loginButton.center.x = self.view.frame.width / 2
            self.signupButton.center.x = self.view.frame.width / 2
        }, completion: nil)
    }
    
    @IBAction func unwindToHomeViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        animateHomePage()
    }
}
