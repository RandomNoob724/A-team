//
//  BackgroundImage.swift
//  Mappy
//
//  Created by Emil Persson on 2019-12-08.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import Foundation

class BackgroundImage : Codable {
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: String
    var download_url: String
}
