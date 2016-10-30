//
//  AlbumImageViewController.swift
//  SpotifySearch
//
//  Created by Victor Zhong on 10/28/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class AlbumImageViewController: UIViewController {
	
	var albumSelected: SpotifyAlbum!
	
	@IBOutlet weak var albumImage: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
	}
	
	func loadData() {
//		var image: UIImage?
//		var data: Data?
		
//		//1. Create a url from the string of the url
//		let url = URL(string: albumSelected.images.full)
//		
//		//2. Create a data object out of the url
//		if let unwrappedURL = url {
//			data = try? Data(contentsOf: unwrappedURL)
//		}
//		
//		//3. Create an image out of the data object created
//		if let realData = data {
//			image = UIImage(data: realData)
//		}
//		
//		albumImage.image = image
		
		APIRequestManager.manager.downloadImage(urlString: albumSelected.images.full) { (returnedData: Data) in
			DispatchQueue.main.async {
				self.albumImage.image = UIImage(data: returnedData)
				self.view.setNeedsLayout()
			}
		}
	}
}
