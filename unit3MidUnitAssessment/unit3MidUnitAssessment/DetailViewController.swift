//
//  DetailViewController.swift
//  unit3MidUnitAssessment
//
//  Created by Erica Y Stevens on 10/29/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var largeAlbumCoverImageView: UIImageView!
    var imageURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let url = URL(string: imageURL) {
            self.largeAlbumCoverImageView.loadImageUsing(url: url)
        } else {
            print("FAILED")
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
