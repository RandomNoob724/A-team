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
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = DataHandler.instance.getBackgroundImageUrl() {
            backgroundImageView.kf.setImage(with: url)
        } else{
            fetchBackgroundImage()
        }

        // Do any additional setup after loading the view.
    }
    
    func fetchBackgroundImage() {
        ImageHandler.fetchBackgroundImage { (success) in
            if success, let url = DataHandler.instance.getBackgroundImageUrl() {
                DispatchQueue.main.async {
                    self.backgroundImageView.kf.setImage(with: url)
                }
            } else{
                print("Error")
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
