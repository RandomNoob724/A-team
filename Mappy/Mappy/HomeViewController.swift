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
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackgroundImage()
    }
    
    func setBackgroundImage(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        if let url = NSURL(string: "https://picsum.photos/414/896/?blur=2"){

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
