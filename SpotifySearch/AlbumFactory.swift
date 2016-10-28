//
//  AlbumFactory.swift
//  SpotifySearch
//
//  Created by Marcel Chaucer on 10/28/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import Foundation

class AlbumFactory {
    
    static let manager = AlbumFactory()
    private init(){}
    
        
    func getAlbumDetails(from jsonData: Data) -> [Album]? {
        
        do {
            let spotifyJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            
            guard let albumsJSONCasted = spotifyJSONData as? [String : Any],
                let albumDictionaries = albumsJSONCasted["albums"] as? [String:Any],
            let actualInfo = albumDictionaries["items"] as? [[String: Any]]
            else {
                    
                    return nil
            }
            
            
            print(albumDictionaries)
            
              var allTheseAlbums: [Album] = []
            for theAlbums in actualInfo {
                guard let albumName = theAlbums["name"] as? String,
                let pictureFiles = theAlbums["images"] as? [[String:Any]],
                let thumbNailPic = pictureFiles[2]["url"],
                let bigPic = pictureFiles[0]["url"]
                    
                    else {
                        return nil
                }
                
            let allTheAlbums = Album(albumTitle: albumName,
                                     thumbNailPic: thumbNailPic as! String,
                                     bigPicture: bigPic as! String)
            
            allTheseAlbums.append(allTheAlbums)
                                }
            
            
            return allTheseAlbums
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return  nil
    }
    

    
    
    func getAlbums(from apiEndpoint: String, callback:@escaping ([Album]?)->()) {
        if let validAlbumEndpoint: URL = URL(string: apiEndpoint) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: validAlbumEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print("Error encountered!: \(error!)")
                }
                if let validData: Data = data {
                    if let allTheGifs = AlbumFactory.manager.getAlbumDetails(from: validData){
                        callback(allTheGifs)
                        if error != nil {
                            print("Error encountered!: \(error!)")
                        }
                    }
                }
                }.resume()
        }
    }
    
    

    
}
