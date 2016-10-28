//
//  SpotyifyTableViewCell.swift
//  AC3.2Unit3MidunitAssessment
//
//  Created by Ilmira Estil on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SpotifyTableViewCell: UITableViewCell {
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var aTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
