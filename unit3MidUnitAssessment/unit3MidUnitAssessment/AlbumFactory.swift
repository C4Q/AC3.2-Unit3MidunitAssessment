//
//  AlbumFactory.swift
//  unit3MidUnitAssessment
//
//  Created by Erica Y Stevens on 10/29/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import Foundation

//This class will be used to retrieve URL info and parse data into objects
class AlbumFactory {
    static let manager: AlbumFactory = AlbumFactory()
    private init () {}
    
    //Makes Album object instances, will be called in ....
    func getAlbums(from jsonData: Data) -> [Album]? {
        do {
            let albumData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            //cast from Any and drill down to the "items" key
            guard let albumsJSONData: [String:AnyObject] = albumData as? [String:AnyObject], let albumsTopLevelDict: [String: AnyObject] = albumsJSONData["albums"] as? [String:AnyObject],
                let albumsArrayOfDicts = albumsTopLevelDict["items"] as? [[String:AnyObject]]  else {
                    print("Casting Failed")
                    return nil
            }
            
            var albums: [Album] = []
            
            albumsArrayOfDicts.forEach({ albumObject in
                guard let albumTitle: String = albumObject["name"] as? String,
                    let albumImageArrDict: [[String:AnyObject]] = albumObject["images"] as? [[String:AnyObject]] else {
                        print("Unable to index into title or images dictionaries")
                        return
                }
                
                guard let smallestImageInSet: String = albumImageArrDict[2]["url"] as? String,
                    let largestImageInSet: String = albumImageArrDict[0]["url"] as? String else {
                        print("Did not access Images")
                        return
                }
                
                //Try to convert imagesInSet from String to URL
                guard let smallestImageURL: URL = URL(string: smallestImageInSet),
                    let largestImageURL: URL = URL(string: largestImageInSet) else {
                        print("Could not convert imageURL string into URL")
                        return
                }
                
                albums.append(Album(title: albumTitle, smallestImageURL: smallestImageURL, largestImageURL: largestImageURL))
            })
            
            return albums
            
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        return nil
    }
}
