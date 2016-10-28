//
//  SearchSettingsViewController.swift
//  AC3.2-Unit3MidunitAssessment
//
//  Created by Tom Seymour on 10/28/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

protocol SearchSettingsDelegate {
    func updateSearchString(newSearchWord: String, numberOfResults: String)
}

class SearchSettingsViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: SearchSettingsDelegate?
    
    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var resultsSlider: UISlider!
    
    var numberOfRestuls = "50"
    var currentSearchWord = "blue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchWordTextField.delegate = self
        searchWordTextField.text = SearchManager.manager.searcWord

        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let allTextFieldText = textField.text ?? "blue"
        let newSearchWord = allTextFieldText.replacingOccurrences(of: " ", with: "%20")
        // tried to do this using a delegate but got stuck so updating manager directly 
        //self.delegate?.updateSearchString(newSearchWord: newSearchWord)
        self.currentSearchWord = newSearchWord
        SearchManager.manager.updateSearchString(newSearchWord: newSearchWord, numberOfResults: self.numberOfRestuls)
         print("*********************************" + newSearchWord)
        return true
    }
    
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        resultsLabel.text = "Number of results: \(String(Int(sender.value)))"
        self.numberOfRestuls = String(Int(sender.value))
        SearchManager.manager.updateSearchString(newSearchWord: currentSearchWord, numberOfResults: self.numberOfRestuls)
        
    }

    
}
