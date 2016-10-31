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
    //internal let albumArrayImages: [[String:String]]
    //internal let albumThumbnailURLString: String = ""
    //internal let albumFullImageURLString: String = ""
    
    
    //String:[String:AnyObject]?
    static func getAlbum(from data: Data) -> [Album]? {
        var allAlbums = [Album]()
        do {
            let data: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let albumDict: [String:Any] = data as? [String:Any]
                else {
                    print("error album dictionary")
                    return nil
            }
            
            guard let albumArr = albumDict["albums"] as? [AnyObject],
                let allItems = albumArr["items"] as? [AnyObject]
                else {
                    print("error allitems")
                    return nil
            }
            
            
            allItems.forEach({ albumObject in
                guard let name: String = albumObject["name"] as? String
                    //let images: [[String:String]] = allItems["images"] as? [[String:String]]
                    //let thumbnailURL: String = images[2]["url"] as? String,
                    //let fullImageURL: String = images[1]["url"] as? String
                    
                    else {
                        print("error main parsing")
                        return
                }
                //print(allAlbums)
                allAlbums.append(Album(albumTitle: name))
                
                
            })
        } catch let error as NSError {
            print("Error retrieving album data \(error)")
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
