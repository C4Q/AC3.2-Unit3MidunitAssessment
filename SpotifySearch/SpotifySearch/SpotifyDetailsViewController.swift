//
//  SpotifyDetailsViewController.swift
//  SpotifySearch
//
//  Created by Marcel Chaucer on 10/28/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class SpotifyDetailsViewController: UIViewController {
    var  albumArt: Album?

    @IBOutlet weak var albumArtView: UIImageView!
    //Had issues with the back button, this website helped resolve it. 
    //http://stackoverflow.com/questions/30326680/added-navigation-bar-but-there-is-no-back-button
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let picture = albumArt {
            self.title = picture.albumTitle
            
            let url = URL(string: picture.bigPicture)
            let data = try? Data(contentsOf: url!)
            albumArtView.image = UIImage(data: data!)
        }    }

    
}
