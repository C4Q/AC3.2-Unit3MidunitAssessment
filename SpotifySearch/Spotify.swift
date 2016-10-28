//
//  Spotify.swift
//  SpotifySearch
//
//  Created by Margaret Ikeda on 10/28/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import UIKit

struct SpotifySearch {
    
    let name: String
    let artist: String
    let imageName: String
    
    init(name: String, artist: String, imageName: String) {
        self.name = name
        self.artist = artist
        self.imageName = imageName
    
    }
    internal func profileImage() -> UIImage? {
        return UIImage(named: imageName)
    }
}
