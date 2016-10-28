//
//  AlbumTableViewCell.swift
//  SpotifySearch
//
//  Created by Sabrina Ip on 10/28/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
