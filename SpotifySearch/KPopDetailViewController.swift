//
//  KPopDetailViewController.swift
//  SpotifySearch
//
//  Created by Ana Ma on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class KPopDetailViewController: UIViewController {
    var album: Album?
    
    @IBOutlet weak var imageLargeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    func setupData() {
        guard let validAlbum = album else {return}
        
        self.navigationItem.title = validAlbum.title
        
        APImanager.getData(endpoint: validAlbum.imageLargeURLString) { (data) in
            DispatchQueue.main.async {
                if data != nil {
                    self.imageLargeImageView.image = UIImage(data: data!)
                }
            }
        }
    }
}
