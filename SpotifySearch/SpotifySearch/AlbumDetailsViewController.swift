//
//  AlbumDetailsViewController.swift
//  SpotifySearch
//
//  Created by Jermaine Kelly on 10/28/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    var album: Album?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumCoverImageView.downloadImage(from: (album?.image ?? nil)!)
        artistNameLabel.text = "Artist: \((album?.artist)!)"
        self.title = album?.name
        self.navigationController?.navigationBar.tintColor = .white
        
        
    }

   
}
