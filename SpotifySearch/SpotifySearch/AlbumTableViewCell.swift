//
//  AlbumTableViewCell.swift
//  SpotifySearch
//
//  Created by Jermaine Kelly on 10/28/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    static let cellIdentifier: String = "AlbumCell"
    
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        albumCoverImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        albumCoverImageView.image = #imageLiteral(resourceName: "no_cover")
    }
    

}
