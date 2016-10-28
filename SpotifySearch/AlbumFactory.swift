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
        guard let url = URL(string: "https://api.spotify.com/v1/search?q=blue&type=album&limit=50") else {return}
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

}
