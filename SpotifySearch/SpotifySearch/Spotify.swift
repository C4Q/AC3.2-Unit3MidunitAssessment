//
//  Spotify.swift
//  SpotifySearch
//
//  Created by Thinley Dorjee on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class Spotify{
    let name: String
    let thumbnail: String
    
    init(name: String, thumbnail: String) {
        self.name = name
        self.thumbnail = thumbnail
    }
    
    static func buildSpotifyArray(from data: Data) -> [Spotify]?{
        do{
            let spotifyJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let spotifyJSONDataDict = spotifyJSONData as? [String: Any] else {return nil}
            guard let arrayOfSpotifyDicts = spotifyJSONDataDict["albums"] as? [[String: Any]] else {return nil}//Got all data
        
            print("11111: \(spotifyJSONDataDict)")
            
            var allTheAlbums = [Spotify]()
            
            for spotifyDicts in arrayOfSpotifyDicts{
                guard let itemsDict = spotifyDicts["items"] as? [String: Any] else {return nil}
                guard let albumName = itemsDict["name"] else {return nil}
                
                guard let itemsImageDict = itemsDict["images"] as? [Dictionary] else {return nil}
                guard let secondImage = itemsImageDict(0) as? [String: String] else {return nil}
                guard let realImage = secondImage["url"] else {return nil}
                
                
                let thisSpotify = Spotify(name: albumName as! String, thumbnail: realImage as! String)
                
                allTheAlbums.append(thisSpotify)

                
                
            }
            return allTheAlbums
            dump(allTheAlbums)
        }
        catch let error as NSError{
            print("Error encountered: \(error)")
        }
        return nil
    }
}
