//
//  uiImageExtension.swift
//  SpotifySearch
//
//  Created by Karen Fuentes on 10/28/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

let cacheImage = NSCache<NSString, UIImage>()
extension UIImageView {
    func downloadImage(urlString: String) {
        if let cachedImaged = cacheImage.object(forKey: urlString as NSString) {
            self.image = cachedImaged
            return
        }
        guard let url = URL(string: urlString) else { return }
        //        var imageData: Data?
        DispatchQueue.global(qos: .background).async {
            do {
                let imageData = try Data(contentsOf: url)
                guard let downloadedImage = UIImage(data: imageData) else { return }
                cacheImage.setObject(downloadedImage, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            } catch let err {
                print("imageData error ==> \n\(err)")
            }
        }
    }
}

