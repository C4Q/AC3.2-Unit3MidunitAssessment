//
//  SearchManager.swift
//  AC3.2-Unit3MidunitAssessment
//
//  Created by Tom Seymour on 10/28/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation


class SearchManager: SearchSettingsDelegate  {
    
    static let manager = SearchManager()
    private init() {}
    
    var searchString: String = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    var searcWord: String = "blue"
    var numberOfResults = "50"
    
    func updateSearchString(newSearchWord: String, numberOfResults: String) {
        self.searchString = "https://api.spotify.com/v1/search?q=\(newSearchWord)&type=album&limit=\(numberOfResults)"
        self.searcWord = newSearchWord
        self.numberOfResults = numberOfResults
        
        print("this is the new search string........................\n\(self.searchString))")
        
    }
}
