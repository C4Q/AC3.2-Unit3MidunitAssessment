//
//  Album.swift
//  SpotifySearch
//
//  Created by Marcel Chaucer on 10/28/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import Foundation

class Album {
    let albumTitle: String
    let thumbNailPic: String
    let bigPicture: String
    
    init(albumTitle: String, thumbNailPic: String, bigPicture: String) {
        self.albumTitle = albumTitle
        self.thumbNailPic = thumbNailPic
        self.bigPicture = bigPicture
    }
}
