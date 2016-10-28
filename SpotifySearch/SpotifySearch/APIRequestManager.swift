//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by Sabrina Ip on 10/28/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import Foundation

internal class APIRequestManager {
    static let manager: APIRequestManager = APIRequestManager()
    init() {}
    
    let apiEndPoint = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    
    func getSearchData(completion: @escaping ((Data?)->Void)) {
        if let validSpotifyEndPoint: URL = URL(string: apiEndPoint) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: validSpotifyEndPoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
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
    
}
