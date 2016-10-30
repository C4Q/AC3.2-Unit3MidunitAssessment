//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by Victor Zhong on 10/28/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import Foundation

internal class APIRequestManager {
	
	internal static let manager: APIRequestManager = APIRequestManager()
	private init() {}
	
	func getAlbumData(searchString: String, completion: @escaping ((Data?)->Void)) {
		let search = searchString.replacingOccurrences(of: " ", with: "%20")
		let endpoint : URL = URL(string: "https://api.spotify.com/v1/search?q=\(search)&type=album&limit=50")!
		
		let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
		session.dataTask(with: endpoint) { (data: Data?, response: URLResponse?, error: Error?) in
			if error != nil {
				print("Error encountered in API request: \(error?.localizedDescription)")
			}
			
			if data != nil {
				print("Data returned in response")
				completion(data)
			}
			
			}.resume()
	}
	
	func downloadImage(urlString: String, callback: @escaping (Data) -> () ) {
		
		guard let imageURL = URL(string: urlString) else { return }
		let session = URLSession.shared
		session.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
			if error != nil {
				print("Error encountered!: \(error!)")
			}
			guard let imageData = data else { return }
			callback(imageData)
			
			}.resume()
	}

}
