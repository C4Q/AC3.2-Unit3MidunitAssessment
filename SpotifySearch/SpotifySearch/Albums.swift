//
//  Albums.swift
//  SpotifySearch
//
//  Created by Sabrina Ip on 10/28/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import Foundation

struct Album {
    let albumName: String
    let imageThumbnail: String
    let imageLarge: String
    
    static func getAlbum(from data: Data) ->[Album]? {
        
        do {
            let spotifyJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let spotifyCasted = spotifyJSONData as? [String : Any],
                let spotifyArr = spotifyCasted["albums"] as? [String: Any],
                let info = spotifyArr["items"] as? [[String: Any]]
                else {return nil}
            
            var albumInfo = [Album]()
 
            info.forEach({ (albumObject) in
                guard let albumTitle = albumObject["name"] as? String,
                    let images = albumObject["images"] as? [[String: Any]],
                    let thumbnailInfo = images[2] as? [String: Any],
                    let thumbnailURL = thumbnailInfo["url"] as? String,
                    
                    let largeImageInfo = images[0] as? [String: Any],
                    let largeImageURL = largeImageInfo["url"] as? String else {return}
                
                let albumDetails = Album(albumName: albumTitle, imageThumbnail: thumbnailURL, imageLarge: largeImageURL)
                albumInfo.append(albumDetails)
            })
            return albumInfo
        }
        catch let error as NSError {
            print("Error occured while parsing data: \(error.localizedDescription)")
        }
        return nil
    }
}
