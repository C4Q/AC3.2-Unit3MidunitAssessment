//
//  Album.swift
//  SpotifySearch
//
//  Created by Edward Anchundia on 10/28/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import Foundation

struct Album {
    
    let albumName: String
    let artistName: String
    let albumCoverImage: URL
    
    init(albumeName: String, artistName: String, albumCoverImage: URL) {
        self.artistName = artistName
        self.albumName = albumeName
        self.albumCoverImage = albumCoverImage
    }
    
}
