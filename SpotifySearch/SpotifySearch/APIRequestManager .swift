//
//  APIRequestManager .swift
//  SpotifySearch
//
//  Created by Kadell on 10/28/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import UIKit

class APIRequestManager {

    internal var manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    class func getURL(apiEndPoint: String, callback: @escaping ((Data?) -> Void )) {
        
        guard let url = URL(string: apiEndPoint) else {return}
        
        let session = URLSession.init(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("******Error in Networking*********")
            }
            
            guard let validData = data else { return }
            callback(validData)
        
        }.resume()
    
    }
}
