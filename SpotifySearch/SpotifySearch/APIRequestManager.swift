//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by Harichandan Singh on 10/28/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

class APIRequestManager {
    //Singleton
    static let manager = APIRequestManager()
    private init() {}
    
    //MARK: - Properties
    let apiEndpoint: String = "https://api.spotify.com/v1/search?q=Frank%20Ocean&type=album&limit=50"
    
    //MARK: - Methods
    func getData(apiEndpoint: String, callback: @escaping (Data?) -> Void) {
        guard let url = URL(string: apiEndpoint) else { return }
        
        let session: URLSession = URLSession.init(configuration: .default)
        
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Encountered an error: \(error)")
            }
            
            guard let spotifyData = data else { return }
            callback(spotifyData)
        }.resume()
    }
}
