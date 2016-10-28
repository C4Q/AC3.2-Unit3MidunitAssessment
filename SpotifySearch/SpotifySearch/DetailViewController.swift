//
//  DetailViewController.swift
//  SpotifySearch
//
//  Created by C4Q on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var albumArt: UIImageView!
    var albumArtURL: String?
    var albumName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.manager.getData(endPoint: albumArtURL!) { (data: Data?) in
            if let d = data {
                DispatchQueue.main.async {
                    self.albumArt.image = UIImage(data: d)
                }
            }
        }
        navigationItem.title = albumName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
