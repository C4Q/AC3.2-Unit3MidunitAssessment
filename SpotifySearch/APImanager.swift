//
//  APImanager.swift
//  SpotifySearch
//
//  Created by Ana Ma on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APImanager {
    let manager: APImanager = APImanager()
    
    private init (){}
    
    static func getData(endpoint: String, complete: @escaping ((Data?) -> Void)) {
        guard let url = URL(string: endpoint) else {return}
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print(error)
            }
            
            guard let validData = data else {
                return
            }
            
            complete(validData)
        }.resume()
        
    }
    
}
