//
//  SearchSettingsViewController.swift
//  AC3.2-Unit3MidunitAssessment
//
//  Created by Tom Seymour on 10/28/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

protocol SearchSettingsDelegate {
    func updateSearch(newSearchWord: String, numberOfResults: String)
}

class SearchSettingsViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: SearchSettingsDelegate?
    
    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var resultsSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchWordTextField.delegate = self
        loadSettingsPage()
        
    }
    
    func loadSettingsPage() {
        searchWordTextField.text = SearchManager.manager.searchTitle
        resultsSlider.value = Float(SearchManager.manager.numberOfResults)!
        resultsLabel.text = "Number of results: \(SearchManager.manager.numberOfResults)"
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let allTextFieldText = textField.text ?? "blue"
        let newSearchWord = allTextFieldText.replacingOccurrences(of: " ", with: "%20")
        // tried to do this using a delegate but got stuck so updating manager directly 
        //self.delegate?.updateSearchString(newSearchWord: newSearchWord)
        SearchManager.manager.updateSearch(newSearchWord: newSearchWord, numberOfResults: SearchManager.manager.numberOfResults)
         print("*********************************" + newSearchWord)
        loadSettingsPage()
        let _ = self.navigationController?.popViewController(animated: true)
        
        return true
    }
    
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        SearchManager.manager.updateSearch(newSearchWord: SearchManager.manager.searchWord, numberOfResults: String(Int(sender.value)))
        loadSettingsPage()
        
    }

    
}
