//
//  ViewController.swift
//  SpotifySearch
//
//  Created by Madushani Lekam Wasam Liyanage on 10/28/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class SpotifyDetailViewController: UIViewController {
    
    @IBOutlet weak var albumImage: UIImageView!
    var playList: PlayList?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = playList?.title
        if let imageString = playList?.imageString {
        albumImage.downloadImage(urlString: imageString)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

