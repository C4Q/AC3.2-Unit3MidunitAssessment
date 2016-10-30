//
//  SpotifyAlbum.swift
//  SpotifySearch
//
//  Created by Karen Fuentes on 10/28/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation

struct SpotifyAlbum {
    let title: String
    let thumbImage: String
    let FullImage: String
    
    static func spotifyJsonDataToArrayofSpotify(from data: Data) -> [SpotifyAlbum]? {
        do {
            let spotifyJsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let spotifyAlbumsCasted: [String:AnyObject] = spotifyJsonData as? [String:AnyObject] else {
                print("there was an error casting to \(spotifyJsonData)")
                return nil
            }
            print("Spotify data was casted")
            guard let spotifyInfoWithinThisKey: Any = spotifyAlbumsCasted["items"] else {
                print("there was an error casting to any for [String:Any] \(spotifyAlbumsCasted)")
                return nil
            }
            print("we were able to get in to the info \(spotifyInfoWithinThisKey)")
            guard let arrayOfSpotifyAlbumObject: [AnyObject] = spotifyAlbumsCasted["items"] as? [AnyObject] else {
                return nil
            }
            
            var arrayOfBlueAlbums: [SpotifyAlbum] = []
            
            arrayOfSpotifyAlbumObject.forEach({ (spotifyObject) in
                guard let spotifyAlbumName: String = spotifyObject["name"] as? String,
                let spotifyImageArray: [[String:Any]] = spotifyObject["images"] as? [[String:Any]],
                let spotifyThumbImageDict: [String:Any] = spotifyImageArray[0] as? [String:Any],
                let spotifyThumbImageUrl: String = spotifyThumbImageDict["url"] as? String,
                let spotifyFullImageDict: [String:Any] = spotifyImageArray[2] as? [String:Any],
                let spotifyFullImageUrl: String = spotifyFullImageDict["url"] as? String
                    else {
                        return
                }
                arrayOfBlueAlbums.append(SpotifyAlbum(title: spotifyAlbumName, thumbImage: spotifyThumbImageUrl, FullImage: spotifyFullImageUrl))
            })
            return arrayOfBlueAlbums
        }
        catch _ as NSError {
            print("ERRRROOOOOOORRRRRR")
        }
        return nil
    }
}
