//
//  AlbumDetailViewController.swift
//  SpotifySearch
//
//  Created by Sabrina Ip on 10/28/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    var albumSelected: Album!
    
    @IBOutlet weak var largeAlbumView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = albumSelected.albumName
        largeAlbumView.downloadImage(urlString: albumSelected.imageLarge)
    }
}
