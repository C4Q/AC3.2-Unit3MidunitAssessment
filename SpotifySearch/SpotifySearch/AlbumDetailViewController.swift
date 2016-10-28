//
//  AlbumDetailViewController.swift
//  SpotifySearch
//
//  Created by Tong Lin on 10/28/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    @IBOutlet weak var largeImage: UIImageView!
    internal var album: Album!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = album.albumName
        
        if let imagedata = try? Data(contentsOf: album.detailImageURL){
            largeImage.image = UIImage(data: imagedata)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
