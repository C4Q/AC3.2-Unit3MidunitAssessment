//
//  AlbumArtController.swift
//  SpotifySearch
//
//  Created by Marty Avedon on 10/28/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class AlbumArtController: UIViewController {

    var chosenAlbum: Albums?
    @IBOutlet weak var albumArt: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = chosenAlbum?.title
        //self.albumArt = chosenAlbum?.cover 
        loadImage((chosenAlbum?.cover)!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func loadImage(_ url: URL) {
        let request: NSURLRequest = NSURLRequest(url: url)
        NSURLConnection.sendAsynchronousRequest(
            request as URLRequest, queue: OperationQueue.main,
            completionHandler: {(response: URLResponse?,data: Data?,error: Error?) -> Void in
                if error == nil {
                    self.albumArt.image = UIImage(data: data!)
                }
        })
        
    }
}
