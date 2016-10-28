//
//  Extention.swift
//  SpotifySearch
//
//  Created by Jermaine Kelly on 10/28/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation
import UIKit


//Extension on the UIView to Download images
//Caching woudl've have also been another option

extension UIImageView {
    func downloadImage(from imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        var imageData: Data?
        DispatchQueue.global(qos: .background).async {
            do {
                imageData = try Data(contentsOf: url)
            } catch let err {
                print("imageData error ==> \n\(err)")
            }
            guard let data = imageData, let downloadedImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                
                self.image = downloadedImage
            
            }
        }
    }
}

    
