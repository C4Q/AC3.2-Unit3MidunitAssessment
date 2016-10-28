//
//  SpotifyManager.swift
//  AC3.2Unit3MidunitAssessment
//
//  Created by Ilmira Estil on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal class SpotifyManager {
    static let manager: SpotifyManager = SpotifyManager()
    private init() {}
    
    func getAlbumData(album: String, completion: @escaping ((Data?) -> Void)) {
        guard let url = URL(string: "https://api.spotify.com/v1/search?q=\(album)&type=album&limit=50") else {return}
        
        let session = URLSession.init(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error!!!!!! \(error!)")
            }
            guard let validData: Data = data else {
                return
            }
            completion(validData)
            }.resume()
    }
    
}
