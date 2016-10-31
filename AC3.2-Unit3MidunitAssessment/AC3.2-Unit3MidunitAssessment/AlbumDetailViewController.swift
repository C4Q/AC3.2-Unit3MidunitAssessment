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
        
        APIHelper.manager.getData(endPoint: thisAlbum.Images.full) { (returnedData: Data?) in
            guard let validData = returnedData else { return }
            DispatchQueue.main.async {
                self.albumCoverImageView.image = UIImage(data: validData)
                self.view.reloadInputViews()
            }
        }
        print(")(*&^%$#@!   \(thisAlbum.Images.full)")
    }

}
