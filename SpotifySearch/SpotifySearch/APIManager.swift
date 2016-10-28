//
//  APIManager.swift
//  SpotifySearch
//
//  Created by C4Q on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIManager {
    
    static let manager = APIManager()
    private init () {}
    
    func getData (endPoint: String, callback: @escaping (Data?) -> Void) {
        print("being called")
        if let validURL = URL(string: endPoint) {
            
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: validURL) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print("Session Error: \(error)")
                }
                
                if let validData = data {
                    print(validData)
                    callback(validData)
                }
            }.resume()
        }
    }
}
