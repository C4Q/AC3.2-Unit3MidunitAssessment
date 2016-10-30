//
//  Album.swift
//  AC3.2-Unit3MidunitAssessment
//
//  Created by Tom Seymour on 10/28/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation


class Album {
    let albumName: String
    let artistName: String
    let Images: SetOfImages
    
    init(albumName: String, artistName: String, images: SetOfImages) {
        self.albumName = albumName
        self.artistName = artistName
        self.Images = images
    }
}

struct SetOfImages {
    let thumnail: String
    let medium: String
    let full: String
}
