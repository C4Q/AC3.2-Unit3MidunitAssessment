//
//  Albums.swift
//  SpotifySearch
//
//  Created by Marty Avedon on 10/28/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

struct Albums {
    var title: String
    var cover: URL
    
    init(title: String, cover: URL) {
        self.title = title
        self.cover = cover
    }
    
    init?(withDict dict: [String:Any]) {
        if let title = dict["name"] as? String,
            let coverImgAddress = dict["season"] as? String,
            let cover: URL = URL(string: coverImgAddress) {

            self.init(title: title, cover: cover)
        }
        else {
            return nil
        }
    }
}
