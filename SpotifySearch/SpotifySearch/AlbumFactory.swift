//
//  AlbumFactory.swift
//  SpotifySearch
//
//  Created by Edward Anchundia on 10/28/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import Foundation

class AlbumFactory {
    
    static let manager: AlbumFactory = AlbumFactory()
    private init() {}
    
    internal func getAlbums(from jsonData: Data) -> [Album]? {
        
        do {
            let albumJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            guard let albumJSONCasted = albumJSONData as? [String : AnyObject],
                let albumArray = albumJSONCasted["album"] as? [String: AnyObject],
                let albumItems = albumArray["item"] as? [[String: Any]] else {
                    return nil
            }
            
            var albums: [Album] = []
            
            albumItems.forEach({ albumObject in
                guard let albumName = albumObject["name"],
                    let albumURLImage = albumObject["URL"],
                    
                    let albumImageURL: URL = URL(string: albumURLImage as! String) else {
                        return
                }
                
                guard let albumArtist = albumObject["artist"] as? [String: String],
                    let albumArtistName = albumArtist["name"] else {
                        return
                    }
                
                albums.append(Album(albumeName: albumName as! String, artistName: albumArtistName, albumCoverImage: albumImageURL))
            })
            
            return albums
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return  nil
    }
    
}
