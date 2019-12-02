//
//  ImageHandler.swift
//  Mappy
//
//  Created by Axel Dalbard on 2019-12-02.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import Foundation

class ImageHandler{
    static func fetchBackgroundImage(completion: ((Bool) -> Void)?) {
        //The API that is used: https://picsum.photos/414/896/?blur=2
        guard let url = URL(string: "https://picsum.photos/414/896/?blur=2") else {
            completion?(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: url) { (responseData, response, responseError) in
            let decoder = JSONDecoder()
            print(try? decoder.decode(BackgroundImage.self, from: responseData!))
            if let data = responseData, let backgroundImage = try? decoder.decode(BackgroundImage.self, from: data){
                print(backgroundImage)
                if backgroundImage.status == "success"{
                    DataHandler.instance.setBackgroundImage(backgroundImage)
                    completion?(true)
                    return
                }
            }
            completion?(false)
        }
        
        task.resume()
    }
}
