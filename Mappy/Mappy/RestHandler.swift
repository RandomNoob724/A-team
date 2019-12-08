//
//  RestHandler.swift
//  Mappy
//
//  Created by Emil Persson on 2019-12-08.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import Foundation
import UIKit

class RestHandler {
    
    static func fetchImage(completion: ((Bool) -> Void)?) {
        // This is the API: https://picsum.photos/id/0/info
        
        guard let url = URL(string: "https://picsum.photos/id/\(Int.random(in: 0..<1000))/info") else {
            // If the url object is nil we'll send false through the callback and end the function.
            completion?(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Most common methods: GET, POST, PUT, DELETE
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // The dataTask functions has a callback with these parameters (Data?, URLResponse?, Error?)
        let task = session.dataTask(with: url) { (responseData, response, responseError) in
            let decoder = JSONDecoder()
            if let data = responseData, let backgroundImage = try? decoder.decode(BackgroundImage.self, from: data) {
                DataHandler.instance.setBackgroundImage(backgroundImage: backgroundImage)
                completion?(true)
                return
            }
            
            // A callback always needs to be called so the the class calling this function gets a response
            // But make sure that the callback is only called once otherwise the app will crash
            completion?(false)
        }
        
        task.resume()
    }
}
