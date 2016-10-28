//
//  AlbumFactory.swift
//  SpotifySearch
//
//  Created by Marty Avedon on 10/28/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

class AlbumFactory {
    static let RCA: AlbumFactory = AlbumFactory()
    private init() {}
    
    
    func getData(completion: @escaping((Data?)->Void)) {
        guard let url = URL(string: "https://api.spotify.com/v1/search?q=swift&type=album&limit=50") else {return}
        // 1. URLSession/Configuration
        let session = URLSession(configuration: .default)
        // 2. Error handling
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print(error)
            }
            // 3. What shall we do with a valid datum?
            guard let validData = data else {return}
            completion(validData)
            }
            // 4. Hand over the data
            .resume()
        print("It's over!")
    }
    
    /* 
    MARK: Read these thoroughly 
     - https://developer.apple.com/swift/blog/?id=37 
     - http://stackoverflow.com/questions/39423367/correctly-parsing-json-in-swift-3
     - https://www.hackingwithswift.com/example-code/system/how-to-parse-json-using-jsonserialization
     */
//    func parseAlbums(from: ) {
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
//            if let names = json["names"] as? [String] {
//                print(names)
//            }
//            } catch let error as NSError {
//        print("Failed to load: \(error.localizedDescription)")
//        }
//    }
    
//    internal func parseAlbums(from jsonData: Data) -> [Albums]? {
//        
//        do {
//            let albumJSON: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
//            
//            // Cast from Any and check for the "albums" key
//            guard let albumJSONCasted: [String : AnyObject] = albumJSON as? [String : AnyObject],
//                let albumStash: [AnyObject] = albumJSONCasted["albums"] as? [AnyObject] else {
//                    return nil
//            }
//            throw error {}
//            
//            // lots of bad stuff in here. can we use the init we designed to run using a dictionary here?
////            var tempArr: [Albums] = []
////            tempArr.forEach({ albumObject in
////                guard let title: String = albumObject["name"] as? String,
////                    let albumCover: String = albumObject["cover"] as? String,
////                    
////                    // Some of these values need further casting
////                    else {
////                        return
////                }
////                
////                // append to our temp array
////                tempArr.append(Albums(title: albumName, cover: albumCover))
////            })
////            
////            return [Albums]
////        }
//        catch let error as NSError {
//            print("Error occurred while parsing data: \(error.localizedDescription)")
//        }
//        
//        return  nil
//    }
    
    func getAlbums(from apiEndpoint: String, callback:@escaping ([Albums]?)->()) {
        if let validEndpoint: URL = URL(string: apiEndpoint) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: validEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print("Error encountered!: \(error!)")
                }
                if let validData: Data = data {
                    if let allTheThings = AlbumFactory.RCA.parseAlbums(from: validData) {
                        callback(allTheThings)
                        if error != nil {
                            print("Error encountered!: \(error!)")
                        }
                    }
                }
                }.resume()
        }
    }
}
