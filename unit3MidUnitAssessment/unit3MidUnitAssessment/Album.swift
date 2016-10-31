//
//  Album.swift
//  unit3MidUnitAssessment
//
//  Created by Erica Y Stevens on 10/29/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import Foundation

class Album {
    var title: String
    var smallestImageURL: URL
    var largestImageURL: URL
    
    
    init(title: String, smallestImageURL: URL, largestImageURL: URL) {
        self.title = title
        self.smallestImageURL = smallestImageURL
        self.largestImageURL = largestImageURL
        
    }
    
    convenience init?(fromDict dict: [String:Any]) {
        if let title = dict["name"] as? String, let smallestImageURL = dict["url"] as? URL, let largestImageURL = dict["url"] as? URL {
            self.init(title: title, smallestImageURL: smallestImageURL, largestImageURL: largestImageURL)
        } else {
            print("Custom Init Failed")
            return nil
        }
    }
}
