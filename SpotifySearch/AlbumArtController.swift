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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Album" //ideally this would be a variable that contains the albums name and title
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
