//
//  AlbumTableViewCell.swift
//  SpotifySearch
//
//  Created by Harichandan Singh on 10/28/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
