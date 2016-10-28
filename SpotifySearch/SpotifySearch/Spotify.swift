//
//  Spotify.swift
//  SpotifySearch
//
//  Created by Annie Tung on 10/28/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class Kaskade {
    let artistName: String
    let imageURL: String
    let albumName: String
    let spotifyURL: String
    
    init(artistName: String, imageURL: String, albumName: String, spotifyURL: String) {
        self.artistName = artistName
        self.imageURL = imageURL
        self.albumName = albumName
        self.spotifyURL = spotifyURL
    }
}
