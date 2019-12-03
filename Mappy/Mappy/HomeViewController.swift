//
//  HomeViewController.swift
//  Mappy
//
//  Created by Axel Dalbard on 2019-12-02.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackgroundImage()
        animateHomePage()
        
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
    func setBackgroundImage(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let width = Int(self.view.frame.width)
        let height = Int(self.view.frame.height)
        
        if let url = NSURL(string: "https://picsum.photos/\(width)/\(height)/?blur=2"){

            let task = session.dataTask(with: url as URL, completionHandler: {data, response, error in

                if let err = error {
                    print("Error: \(err)")
                    return
                }

                if let http = response as? HTTPURLResponse {
                    if http.statusCode == 200 {
                        let downloadedImage = UIImage(data: data!)
                         DispatchQueue.main.async {
                            self.backgroundImageView.image = downloadedImage
                        }
                    }
                }
           })
            task.resume()
        }
    }
    
    @IBAction func unwindToHomeViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        animateHomePage()
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
