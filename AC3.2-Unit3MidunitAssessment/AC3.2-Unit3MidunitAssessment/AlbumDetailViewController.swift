//
//  AlbumDetailViewController.swift
//  AC3.2-Unit3MidunitAssessment
//
//  Created by Tom Seymour on 10/28/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    var thisAlbum: Album!
    
    @IBOutlet weak var albumCoverImageView: UIImageView!
    
    @IBOutlet weak var albumInfoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailPage()
    }
    
    func loadDetailPage() {
        navigationItem.title = thisAlbum.albumName
        albumInfoLabel.text = ("Album Name: \(thisAlbum.albumName)\nby: \(thisAlbum.artistName)")
        
        APIHelper.manager.downloadImage(urlString: thisAlbum.Images.fullsize) { (returnedData: Data) in
            DispatchQueue.main.async {
                self.albumCoverImageView.image = UIImage(data: returnedData)
                self.view.reloadInputViews()
            }
        }
        print(")(*&^%$#@!   \(thisAlbum.Images.fullsize)")
    }

    
}
