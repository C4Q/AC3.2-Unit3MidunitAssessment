//
//  Spotify.swift
//  AC3.2Unit3MidunitAssessment
//
//  Created by Ilmira Estil on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal struct Album {
    internal let albumTitle: String
    internal let albumArrayImages: [[String:String]]
    internal let albumThumbnailURLString: String = ""
    internal let albumFullImageURLString: String = ""
    
    
    //String:[String:AnyObject]?
    static func getAlbum(from data: Data) -> [Album]? {
        do {
            let albumJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let albumCasted: [String:AnyObject] = albumJSONData as? [String:AnyObject],
                let albumArray: [AnyObject] = albumCasted["albums"] as? [AnyObject] else {return nil}
            
            var allAlbums = [Album]()
            albumArray.forEach({ albumObject in
                guard let allItems: [String:Any] = albumObject["items"] as? [String:Any],
                    let name: String = allItems["name"] as? String,
                    let images: [[String:String]] = allItems["images"] as? [[String:String]]
                    
                    //let thumbnailURL: String = images[2]["url"] as? String,
                    //let fullImageURL: String = images[1]["url"] as? String
                    
                    else {
                        
                       print("error")
                        return
                }
                
                allAlbums.append(Album(albumTitle: name, albumArrayImages: images))
                
                
            })
        } catch _ as NSError {
            print("Error retrieving album data")
        }
        return nil
    }
    /*
    func getImage() ->  String {
        var picArr = ""
        
        for image in albumArrayImages {
            if Int(image["height"]!)! < 70 {
                picArr = image["url"]!
            }
            return picArr
        }
    }
 */
}
