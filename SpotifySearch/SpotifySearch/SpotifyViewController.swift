//
//  SpotifyViewController.swift
//  SpotifySearch
//
//  Created by Annie Tung on 10/28/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit

class SpotifyViewController: UIViewController {
    
    var kas: Kaskade!

    @IBOutlet weak var imageURL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIRequestManager.manager.getSpotifyData(apiEndPoint: kas.imageURL) { (data: Data?) in
            DispatchQueue.main.async {
                if let d = data {
                    self.imageURL.image = UIImage(data: d)
                }
                return
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
