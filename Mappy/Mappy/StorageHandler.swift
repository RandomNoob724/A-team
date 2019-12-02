//
//  StorageHandler.swift
//  Mappy
//
//  Created by Axel Dalbard on 2019-12-02.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import Foundation

class StorageHandler {
    private static let BGIMAGE_KEY = "BackgroundImageKey"
    
    static func setBackgroundImageUrl(_ url: String){
        UserDefaults.standard.set(url, forKey: BGIMAGE_KEY)
    }
    
    static func getBackgroundImageUrl() -> String?{
        return UserDefaults.standard.string(forKey: BGIMAGE_KEY)
    }
}
