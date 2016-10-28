//
//  Albums.swift
//  SpotifySearch
//
//  Created by Kadell on 10/28/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import Foundation

internal struct Albums {
    
    internal let nameOfAlbum: String
    internal let thumbnailImage: String
    internal let urlOfImage: String
  
    
    static func eachAlbum(data: Data) -> [Albums]? {
        do {
            let albumData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let albumDataCasted = albumData as? [String: Any] else {
                print("Their was an Error Casting to \(albumData)")
                return nil
            }
            print("***********Success into the JSON **********")
            
            guard let arrayOfAlbums = albumDataCasted["albums"] as? [String: Any] else {
                print("Their was an Error Casting to \(albumDataCasted)")
                    return nil
            }
            print("+++++++++++We in here+++++++++")
            
            guard let itemsArray = arrayOfAlbums["items"] as? [[String:Any]] else {
                print("Problem with Items ++++*********")
                return nil
            }
            
            print("***********Seee How far IM in*****************")
            
              var allAlbums: [Albums] = []
            
            for dict in itemsArray {
                guard let albumTitle = dict["name"] as? String else {return nil}
                print("**********Print those Album names \(albumTitle)*************")
                guard let intoImage = dict["images"] as? [[String: Any]] else {return nil }
                print("************I got access or nah?************")
                guard let largeImage = intoImage[0]["url"] as? String else {return nil}
                print("********* Momma I made it let me see that url: \(largeImage) ")
                guard let smallImage = intoImage[2]["url"] as? String else {return nil}
          
                let dataOfAlbums = Albums(nameOfAlbum: albumTitle,thumbnailImage:smallImage, urlOfImage: largeImage)
                allAlbums.append(dataOfAlbums)
            }
            return allAlbums
            
        }
        catch {
            print("Error on the Catch \(error)")
        }
        return nil
    }


}
