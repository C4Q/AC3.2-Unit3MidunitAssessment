//
//  APIManager.swift
//  SpotifySearch
//
//  Created by C4Q on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIManager {
    
    var endPoint = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    
    static let manager = APIManager()
    private init () {}
    
    func getData (endPoint: String, callback: @escaping (Data?) -> Void) {
        print("getData being called")
        if let validURL = URL(string: endPoint) {
            
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: validURL) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print("Session Error: \(error)")
                }
                
                if let validData = data {
                    callback(validData)
                }
            }.resume()
        }
    }
    
    func upDateEndPoint (term: String) {
        let searchTerm = term.replacingOccurrences(of: " ", with: "%20")
        self.endPoint = "https://api.spotify.com/v1/search?q=\(searchTerm)&type=album&limit=50"
    }
}
