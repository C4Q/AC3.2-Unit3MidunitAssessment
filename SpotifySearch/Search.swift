//
//  Search.swift
//  SpotifySearch
//
//  Created by Margaret Ikeda on 10/28/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation

//below is chopped up code from Louis Tur's FacesterGram, which I was here for but couldn't keep up with because of the internet connectivity problems. I'm so lost when it comes to APIs. I also shouldn't have missed last Thursday and Friday after the gala when we did InstaCats and Dogs. FascesterGram built on that a lot and I was oblivious.

class Search {
    var
}
static func artist(from data: Data) -> [Search]? {
    var artistsToReturn: [Search]? = []
    
    do {
        // 1. Attempt to serialize data
        let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
        
        // 2. begin parsing to our array of user data objects
        guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
            let results: [AnyObject] = response["results"] as? [AnyObject] else {
                return nil
        }
        
        // 3. Iterrate over each element
        for userResult in results {
            
            // 4. parse out name
            guard
                let name: [String : String] = userResult["name"] as? [String : String],
                else {
                    continue
                    //                    return nil
            }
            catch {
                print("Error encountered with JSONSerialization: \(error)")
            }
            
            return nil
        }
        
    }
}
