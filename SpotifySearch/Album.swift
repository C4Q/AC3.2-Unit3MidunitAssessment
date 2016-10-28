//
//  Album.swift
//  SpotifySearch
//
//  Created by Ana Ma on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum UserModelParseError: Error {
    case dictionary
    case albums
    case itemsArray
    case itemDictionary
    case albumName
    case images
    case image
    case imageLarge
    case imageThumb
}

struct Album {
    var title: String
    var imageThumbURLString: String
    var imageLargeURLString: String
    
    static func getAlbum (data: Data) -> [Album]? {
        var albumArray = [Album]()
        do {

            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dictionary = jsonData as? [String:Any] else {
                throw UserModelParseError.dictionary
            }
            
            guard let albums = dictionary["albums"] as? [String:Any] else {
                throw UserModelParseError.albums
            }
            
            guard let itemsArray = albums["items"] as? [Any] else {
                throw UserModelParseError.itemsArray
            }
            
            for item in itemsArray {
                guard let itemDictionary = item as? [String: Any] else {
                    throw UserModelParseError.itemDictionary
                }
                
                guard let albumName = itemDictionary["name"] as? String else {
                    throw UserModelParseError.albumName
                }
                
                guard let images = itemDictionary["images"] as? [[String: Any]] else {
                    throw UserModelParseError.images
                }
                
                guard let imageLarge = images[0] as? [String:Any],
                    let imageLargeURLString = imageLarge["url"] as? String else {
                    throw UserModelParseError.imageLarge
                }
                
                
                guard let imageThumb = images[2] as? [String:Any],
                    let imageThumbURLString = imageThumb["url"] as? String else {
                    throw UserModelParseError.imageThumb
                }
                
                let album = Album(title: albumName, imageThumbURLString: imageThumbURLString, imageLargeURLString: imageLargeURLString)
                albumArray.append(album)
                
//                for image in images {
//                    guard let imageLarge = images[
////                    guard let image = image as? [String:Any] else {
////                        throw UserModelParseError.image
////                    }
//                    guard let imageLargeURLString = image[""]
//                }
                
            }
            return albumArray
//            print("dictionary casted")
//            print("albums casted")
//            print("items array casted")
//            print("item dictionary casted")
//            print("album Name casted")
//            print("imageLarge casted")
//            print("imageThumb casted")
            //dump(jsonData)
        }
        

        catch UserModelParseError.dictionary {
            print("There's an error in casting dictionary")
        }
        
        catch UserModelParseError.albums {
            print("There's an error in casting albums")
        }
            
        catch UserModelParseError.itemsArray {
            print("There's an error in casting items array")
        }
            
        catch UserModelParseError.itemDictionary {
            print("There's an error in casting item dictionary")
        }
        
        catch UserModelParseError.albumName {
            print("There's an error in casting album name")
        }
            
        catch UserModelParseError.images {
            print("There's an error in casting images")
        }
        
        catch UserModelParseError.image {
            print("There's an error in casting image")
        }
            
        catch UserModelParseError.imageLarge{
            print("There's an error in casting image large")
        }
        
        catch UserModelParseError.imageThumb {
            print("There's an error in casting image thumb")
        }
            
        catch {
            print(error)
        }
        return nil
    }
    
}
