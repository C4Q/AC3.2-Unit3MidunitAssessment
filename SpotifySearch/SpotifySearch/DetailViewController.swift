//
//  DetailViewController.swift
//  SpotifySearch
//
//  Created by Thinley Dorjee on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var DetialImage: UIImageView!
    
    var detailImage: Spotify!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpotifyAPIFactory.manager.downloadImage(urlString: detailImage.realImage) { (returnedData: Data) in
            DispatchQueue.main.async {
                self.detailImage.image = UIImage(data: returnedData)
                self.view.reloadInputViews()
            }
        }
        self.title = "\(detailImage.name)"
    }
}
    


