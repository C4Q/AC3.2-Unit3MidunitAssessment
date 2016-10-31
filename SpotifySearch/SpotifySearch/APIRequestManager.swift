//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by Cris on 10/28/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation

class APIRequestManager {
    static let manager: APIRequestManager = APIRequestManager()
    init() {}
        
    
    func getSongsUsingAPI(artist: String = "Kanye", type: String = "album", market: String = "US", completion:@escaping ((Data?)->Void)) {
       
//      let APIString = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
        let APIString = "https://api.spotify.com/v1/search?q=\(artist)&type=\(type)&market=\(market)&limit=\(SettingsManager.manager.limit)"
        let search = searchWithWhiteSpace(searchTerm: APIString)
        let search2 = artist.addingPercentEncoding(withAllowedCharacters: <#T##CharacterSet#>)
        let APIURL = URL(string: search)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: APIURL!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered!: \(error!)")
            }
            if let validData: Data = data {
                print(validData)
                completion(validData)
            }
        }.resume()
    }
    
    func searchWithWhiteSpace(searchTerm: String) -> String {
        var newSearchterm = searchTerm
        
        if searchTerm.contains(" ") {
            newSearchterm = searchTerm.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        }
        
        return newSearchterm
    }
    
}
