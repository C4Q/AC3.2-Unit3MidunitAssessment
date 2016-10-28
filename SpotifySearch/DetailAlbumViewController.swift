//
//  DetailAlbumViewController.swift
//  SpotifySearch
//
//  Created by Ana Ma on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailAlbumViewController: UIViewController {

    var album: Album?
    
    @IBOutlet weak var imageLargeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
