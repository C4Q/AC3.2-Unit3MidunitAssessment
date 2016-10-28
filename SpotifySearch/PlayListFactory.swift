//
//  PlayListFactory.swift
//  SpotifySearch
//
//  Created by Madushani Lekam Wasam Liyanage on 10/28/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class PlayListFactory {
    
    static let manager: PlayListFactory = PlayListFactory()
    private init() {}
    
    class func makePlayList(apiEndpoint: String, callback: @escaping ([PlayList]?) -> Void) {
        
        if let validPlayListEndpoint: URL = URL(string: apiEndpoint) {
            
            // 1. URLSession/Configuration
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // 2. dataTaskWithURL
            session.dataTask(with: validPlayListEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
                // 3. check for errors right away
                if error != nil {
                    print("Error encountered!: \(error!)")
                }
                
                // 4. printing out the data
                if let validData: Data = data {
                    print(validData) // not of much use other than to tell us that data does exist
                    
                    if let allThePlayList: [PlayList] = PlayListFactory.manager.getPlayList(from: validData) {
                        //to update the UI with data when view loads (otherwise you'll have to manually scroll to get the data
                        print(allThePlayList)
                        callback(allThePlayList)
                        
                    }
                }
                
                }.resume()
            
        }
        
    }
    
    //    do {
    //    let giphyJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
    //
    //    // Cast from Any and check for the "cats" key
    //    guard let giphyJSONCasted: [String : AnyObject] = giphyJSONData as? [String : AnyObject],
    //    let giphyArray: [AnyObject] = giphyJSONCasted["data"] as? [AnyObject] else {
    //    return nil
    //    }
    //
    
    
    
    
    
    internal func getPlayList(from jsonData: Data) -> [PlayList]? {
        
        do {
            let playListJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            guard let playListJSONCasted: [String : AnyObject] = playListJSONData as? [String : AnyObject],
               // let albumDict: [String:AnyObject] = playListJSONCasted["albums"] as? [String:AnyObject],
                let playListArray: [AnyObject] = playListJSONCasted["albums"]?["items"] as? [AnyObject]
                
                else {
                    return nil
            }
            
                var playList: [PlayList] = []
                
                playListArray.forEach({ playListObject in
                    guard let albumName: String = playListObject["name"] as? String,
                        let albumImagesArray: [Any] = playListObject["images"] as? [Any],
                       let albumImageDict: [String:Any] = albumImagesArray[0] as? [String:Any],
                        let albumThumbnailDict: [String:Any] = albumImagesArray[2] as? [String:Any],
                       let albumThumbnailString: String = albumThumbnailDict["url"] as? String,
                        let albumImageString: String = albumImageDict["url"] as? String
                        else {return}
                    playList.append(PlayList(title: albumName, thumbnailImageString: albumThumbnailString, imageString: albumImageString))
                })
                return playList
            
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return  nil
    }
}
