//
//  Album.swift
//  SpotifySearch
//
//  Created by C4Q on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

struct Album {
    
    var albumName: String
    var thumbImageURLString: String
    var fullImageURLString: String
    var artistName: String
    
    
    
    static func parseData (with data: Data) -> [Album]? {
        var arr: [Album] = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let firstLayerOfCasting = jsonData as? [String:Any] else {
                print("******Error on first casting******")
                return nil
            }
            guard let secondLayerOfCasting = firstLayerOfCasting["albums"] as? [String: Any] else{
                print("******Error on second casting******")
                return nil
            }
            guard let albumDictionaryArray = secondLayerOfCasting["items"] as? [[String: Any]] else {
                print("******Error on third casting******")
                return nil
            }
            for albumDictionary in albumDictionaryArray {
                guard let albumName = albumDictionary["name"] as? String else {print("error casting album name")
                    return nil}
                guard let images = albumDictionary["images"] as? [[String:AnyObject]] else {print("error casting imagesDict")
                    return nil}
                guard let thumbImage = images[2]["url"] as? String, let fullImage = images[0]["url"] as? String else {print("error parsing the two images")
                    return nil
                }
                guard let artistsArray = albumDictionary["artists"] as? [[String:AnyObject]] else {print("error casting artistDict")
                    return nil}
                guard let artistName = artistsArray[0]["name"] as? String else {print("error casting artistName")
                    return nil}
                
                
                arr.append(self.init(albumName: albumName, thumbImageURLString: thumbImage, fullImageURLString: fullImage, artistName: artistName))
                
                
            }
            
        }
        catch {
            print("Error: \(error)")
        }
        return arr
    }
}
