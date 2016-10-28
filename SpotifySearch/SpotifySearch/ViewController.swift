//
//  ViewController.swift
//  SpotifySearch
//
//  Created by Kadell on 10/28/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var moreAlbums: Albums?
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = moreAlbums?.nameOfAlbum
        if let detail = moreAlbums  {
            guard let imageUrl = URL(string: detail.urlOfImage) else {return }
            let imageData = try! Data(contentsOf: imageUrl)
            albumCoverImage.image = UIImage(data: imageData)
            albumCoverImage.layer.cornerRadius = 5
            albumCoverImage.layer.masksToBounds = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

