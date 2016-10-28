//
//  Album.swift
//  SpotifySearch
//
//  Created by Tong Lin on 10/28/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import Foundation

internal struct Album{

    let albumName: String
    let artistsName: String
    let cellImageURL: URL
    let detailImageURL: URL
    let spotifyURL: URL
    
    init(albumName: String, artistsName: String, cellImageURL: URL, detailImageURL: URL, spotifyURL: URL) {

        self.albumName = albumName
        self.artistsName = artistsName
        self.cellImageURL = cellImageURL
        self.detailImageURL = detailImageURL
        self.spotifyURL = spotifyURL
    }
}
