//
//  ApiManager.swift
//  SpotifySearch
//
//  Created by Margaret Ikeda on 10/28/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation

internal class ApiManager {
    private static let SpotifyEndpoint: URL = URL(string: "https://api.spotify.com/v1/search?q=blue&type=album&limit=50")!
    
    internal static let manager: ApiManager = ApiManager()
    private init() {}
    
    func getSpotifySearchData(completion: @escaping ((Data?)->Void)) {
        
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: ApiManager.SpotifyEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered in API request: \(error?.localizedDescription)")
            }
            
            if data != nil {
                print("Data returned in response")
                completion(data)
            }
            
            }.resume()
    }
    
    func getAlbumArtist (name: String, completion: @escaping ((Data?)->Void) ) {
        let albumArtistEndpoint = URL(string: "https://randomuser.me/api/?results=\(name)")!
        
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: albumArtistEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered in API request: \(error?.localizedDescription)")
            }
            
            if data != nil {
                print("Data returned in response")
                completion(data)
            }
            
            }.resume()
    }
    }
