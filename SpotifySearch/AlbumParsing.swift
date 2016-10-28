//
//  AlbumParsing.swift
//  SpotifySearch
//
//  Created by John Gabriel Breshears on 10/28/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import Foundation

struct Album {
    let albumName: String
    let imageUrl: String
    
   static func album(from data: Data) ->[Album]? {
    // Data is not getting through. SOmething is wrong with my parsaing/casting. The whole thing is a dictionary. "albums" is a dictionary with the value of a dictionary. Then "items" is a dictionary with the value of an array of dictionaries.
        do {
            let albumJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let albumCasted = albumJSONData as? [String : Any],
            
                let albumDic = albumCasted["albums"] as? [String : Any],
                let itemArrDic = albumDic["items"] as? [[String : Any]] else {return nil}
            
            var albumInfo = [Album]()
            
            itemArrDic.forEach({ (albumObject) in
                guard let albumName = albumObject["name"] as? String,
                let imagesArrDict = albumObject["images"] as? [[String : Any]],
                let imageIndex = imagesArrDict[0] as? [String : Any],
                let image = imageIndex["url"] as? String
                
                else{return}
                
                
                let albumDetail = Album(albumName: albumName, imageUrl: image)
                albumInfo.append(albumDetail)
            
            
        })
        return albumInfo
        
    }
        catch let error as NSError {
            print("Error occured while parsing data: \(error.localizedDescription)")
        }
    return nil
    
}
}
/*
 static func giphy(from data: Data) ->[Giphy]? {
 
 do {
 let giphyJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
 guard let giphyCasted = giphyJSONData as? [String : Any],
 let giphyArr = giphyCasted["data"] as? [[String : Any]] else {return nil}
 
 var giphyInfo = [Giphy]()
 
 giphyArr.forEach({ (giphyObject) in
 guard let giphyName = giphyObject["slug"] as? String,
 let giphyID = giphyObject["id"] as? String,
 let imageDicts = giphyObject["images"] as? [String : Any],
 
 //Additional Parsing
 let giphyImageURLS = imageDicts["fixed_height_still"] as? [String : String],
 let giphyImageString = giphyImageURLS["url"],
 let giphyMovingURLS = imageDicts["fixed_height"] as? [String : String],
 let giphyMovingString = giphyMovingURLS["url"] else {return}
 
 let giphyDetails = Giphy(name: giphyName, urlStillImage: giphyImageString, urlmovingGif: giphyMovingString, id: giphyID)
 giphyInfo.append(giphyDetails)
 })
 return giphyInfo
 }
 catch let error as NSError {
 print("Error occured while parsing data: \(error.localizedDescription)")
 }
 return nil
 }
 
 
 }
 
 */
