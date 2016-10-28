//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by John Gabriel Breshears on 10/28/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import Foundation

//1. Create a Singleton, Gabriel.
//Singleton are usually classes,
// Remember to create an instance called mananger of type APIRequestManager

internal class APIRequestManager {
    static let manager: APIRequestManager = APIRequestManager()
    init() {}
    
    //2. Alright, I created an endpoint but now I need to convert it to a URL
    let apiEndPoint = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    
    func getAlbumData(completion: @escaping ((Data?) ->Void)) {
        if let vaildAlbumEndPoint: URL = URL(string: apiEndPoint) {
            //3. Look up Session. I believe it starts the data pulling
            let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: vaildAlbumEndPoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    print("Error encounter!: \(error)")
                    
                }
                if let validData: Data = data {
                    print(validData)
                    completion(validData)
                }
                
                }.resume()
        }
    }
    
}

/*
 
 func getGiphyData(completion: @escaping ((Data?)->Void)) {
 if let validGiphyEndPoint: URL = URL(string: apiEndPoint) {
 let session = URLSession(configuration: URLSessionConfiguration.default)
 session.dataTask(with: validGiphyEndPoint) { (data: Data?, response: URLResponse?, error: Error?) in
 
 if error != nil {
 print("Error encountered!: \(error)")
 }
 if let validData: Data = data {
 print(validData)
 completion(validData)
 }
 }.resume()
 }
 }
 

 
 
 */
