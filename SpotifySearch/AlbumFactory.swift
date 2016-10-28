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
    
//    internal func getAlbums(from jsonData: Data) -> [Albums]? {
//        
//        do {
//            let jSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
//            
//            // Cast from Any and check for the "albums" key
//            guard let jSONCasted: [String : AnyObject] = jSONData as? [String : AnyObject],
//                let levelOne: [AnyObject] = jSONCasted["albums"] as? [AnyObject] else {
//                    return nil
//            }
//            
//        catch let error as NSError {
//            print("Error occurred while parsing data: \(error.localizedDescription)")
//        }
//        
//        return  nil
//        }
//    
////    func getInstaCatsTwo(from apiEndpoint: String, callback:@escaping ([InstaCat]?)->()) {
////        if let validInstaCatEndpoint: URL = URL(string: apiEndpoint) {
////            let session = URLSession(configuration: URLSessionConfiguration.default)
////            session.dataTask(with: validInstaCatEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
////                if error != nil {
////                    print("Error encountered!: \(error!)")
////                }
////                if let validData: Data = data {
////                    if let allTheCats = InstaCatFactory.manager.getInstaCats(from: validData) {
////                        callback(allTheCats)
////                        if error != nil {
////                            print("Error encountered!: \(error!)")
////                        }
////                    }
////                }
////                }.resume()
////        }
////    }

}
