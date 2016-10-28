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
    //var cover: (URL, URL) //ideally, we'd like to grab the biggest img for the album art view and the smallest img for the table view but let's just get one img for now
    var cover: URL //we could make loading the image a lot easier if we could have this be a UIImage but assigning it that type gives errors
    
    init(title: String, cover: URL) { //, URL)) {
        self.title = title
        self.cover = cover
    }
    
    init?(withDict dict: [String:Any]) {
        if let title = dict["name"] as? String, //oh shit there are two keys that are called name. better be careful when parsing
            let coverImgAddress = dict["images"] as? String,
            let cover: URL = URL(string: coverImgAddress) {

            self.init(title: title, cover: cover)
        }
        else {
            return nil
        }
    }
}
