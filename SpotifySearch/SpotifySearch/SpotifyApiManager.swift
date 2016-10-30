//
//  SpotifyApiManager.swift
//  SpotifySearch
//
//  Created by Karen Fuentes on 10/28/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation

class SpotifyApiManager {
    static let manager: SpotifyApiManager = SpotifyApiManager()
    init(){}
    
    func getSpotifyJsonData (completion: @escaping ((Data?) -> Void)) {
        guard let url = URL(string:"https://api.spotify.com/v1/artists/6vWDO969PvNqNYHIOW5v0m/albums?limit%20=20") else {return}
        let session = URLSession.init(configuration: .default)
        session.dataTask(with: url) { (data:Data? , response: URLResponse? , error:Error?) in
            if error != nil {
                print("there is an error of type \(error)")
            }
            guard let validData = data else {
                return
            }
            
            completion(validData)
            
            } .resume()
        
    }
    
}
