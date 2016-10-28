//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by Victor Zhong on 10/28/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import Foundation

internal class APIRequestManager {
	private static let albumAPIEndpoint: URL = URL(string: "https://api.spotify.com/v1/search?q=bat%20out%20of%20hell&type=album&limit=50")!
	
	internal static let manager: APIRequestManager = APIRequestManager()
	private init() {}
	
	func getAlbumData(completion: @escaping ((Data?)->Void)) {
		
		let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
		session.dataTask(with: APIRequestManager.albumAPIEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
			if error != nil {
				print("Error encountered in API request: \(error?.localizedDescription)")
			}
			
			if data != nil {
				print("Data returned in response")
				completion(data)
			}
			
			}.resume()
	}
}
