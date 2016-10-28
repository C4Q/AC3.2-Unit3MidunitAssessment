//
//  Album.swift
//  SpotifySearch
//
//  Created by Jermaine Kelly on 10/28/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation
import UIKit

struct Album{
    let name: String
    let image : String
    let artist : String
    let type: String
    
    
    
    static func createObj(data: Data) -> [Album]?{
        
        var albums : [Album] = []
        
        do{
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonCastData: [String: Any] = jsonData as? [String:Any] else { return nil }
            
            guard let albumSearchResultItems: [String: Any] = jsonCastData["albums"] as? [String:Any] else {return nil}
            
            guard let albumsArray: [[String:Any]] = albumSearchResultItems["items"] as? [[String:Any]] else { return nil}
            
            
            for albumInfo in albumsArray{
                
                guard let albumtype:String = albumInfo["album_type"] as? String else { return nil}
                
                guard let artistInfo : [[String:Any]] = albumInfo["artists"] as? [[String:Any]],
                    let artistName: String = artistInfo[0]["name"] as? String else {return nil}
                
                guard let albumName: String = albumInfo["name"] as? String else { return nil}
                
                guard let albumImageUrl: [[String:Any]] = albumInfo["images"] as? [[String:Any]],
                    let imageUrl: String = albumImageUrl[1]["url"] as? String else {return nil}
                
                albums.append(Album(name: albumName, image: imageUrl, artist: artistName, type: albumtype))
    
            }
            
            return albums
            
            
        }catch{
            print (error.localizedDescription)
            
        }
    
        return nil
        
    }
}
