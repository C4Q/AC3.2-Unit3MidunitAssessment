//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by Annie Tung on 10/28/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static var manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    func getSpotifyData(apiEndPoint: String, callback: @escaping ((Data?) -> Void)) {
        
        guard let validUrl: URL = URL(string: apiEndPoint) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: validUrl) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("*****Error Encountered at \(error)")
            }
            
            guard let validData = data else { return }
            print(validData)
            
            callback(validData)
        }.resume()
    }
    
}
