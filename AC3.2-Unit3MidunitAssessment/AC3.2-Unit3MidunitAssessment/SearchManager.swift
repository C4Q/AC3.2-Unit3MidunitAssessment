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
    var searchWord: String = "blue"
    var searchTitle: String {
        let searchWords = searchWord.replacingOccurrences(of: "%20", with: " ")
        let titleArray = searchWords.components(separatedBy: " ")
        var searchTitle = ""
        for word in titleArray {
            searchTitle += word.capitalized
            searchTitle += " "
        }
        searchTitle = String(searchTitle.characters.dropLast(1))
        return searchTitle
    }
    var numberOfResults = "50"
    
    func updateSearch(newSearchWord: String, numberOfResults: String) {
        self.searchString = "https://api.spotify.com/v1/search?q=\(newSearchWord)&type=album&limit=\(numberOfResults)"
        self.searchWord = newSearchWord
        self.numberOfResults = numberOfResults
        
        print("this is the new search string........................\n\(self.searchString))")
        
    }
}
