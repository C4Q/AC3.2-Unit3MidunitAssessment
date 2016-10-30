//
//  SpotifyAlbumTableViewCell.swift
//  SpotifySearch
//
//  Created by Karen Fuentes on 10/28/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class SpotifyAlbumTableViewCell: UITableViewCell {


    
    @IBOutlet weak var spotifyAbumThumb: UIImageView!
    @IBOutlet weak var spotifyAlbumTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
