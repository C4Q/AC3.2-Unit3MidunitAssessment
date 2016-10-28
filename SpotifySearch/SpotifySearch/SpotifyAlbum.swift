//
//  SpotifyAlbum.swift
//  SpotifySearch
//
//  Created by Victor Zhong on 10/28/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import Foundation

internal enum AlbumModelParseError: Error {
	case results, artist, album, image, imageBig, imageThumb
}

internal struct SpotifyAlbum {
	
	let artistName: String
	let albumName: String
	let imageURL: String
	let thumbURL: String
	
	static func albums(from data: Data) -> [SpotifyAlbum]? {
		var albumsToReturn: [SpotifyAlbum]? = []
		
		do {
			// 1. Attempt to serialize data
			let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
			
			// 2. begin parsing to our array of user data objects
			guard let response: [String : Any] = jsonData as? [String : Any],
				let resultsPrep: [String : Any] = response["albums"] as? [String : Any],
				let results: [[String : Any]] = resultsPrep["items"] as? [[String : Any]] else {
					throw AlbumModelParseError.results
			}
			print("We've got \(results.count) results!")
			
			// 3. Iterate over each element
			for albumResult in results {
				
				// 4. parse out album name
				guard let albumName: String = albumResult["name"] as? String
					else {
						throw AlbumModelParseError.album
				}
				
				// 4.5 parse out artist name
				guard let artist: [[String : Any]] = albumResult["artists"] as? [[String : Any]],
					let artistName: String = artist[0]["name"] as? String
					else {
						throw AlbumModelParseError.artist
				}
				
				
				// 5. parse out image and thumbnail URLs
				guard let images: [[String : Any]] = albumResult["images"] as? [[String : Any]]
					else {
						throw AlbumModelParseError.image
				}
				
				guard let imageURL: String = images[0]["url"] as? String
					else {
						throw AlbumModelParseError.imageBig
				}
				
				guard let thumbURL: String = images[2]["url"] as? String
					else {
						throw AlbumModelParseError.imageThumb
				}
				
				let validAlbum: SpotifyAlbum = SpotifyAlbum(artistName: artistName,
				                                            albumName: albumName,
				                                            imageURL: imageURL,
				                                            thumbURL: thumbURL)
				
				albumsToReturn?.append(validAlbum)
			}
			
			print("Returning \(albumsToReturn?.count) albums")
			return albumsToReturn
		}
		catch {
			print("Error encountered with JSONSerialization: \(error)")
		}
		
		return nil
	}
	
}
/*
>>>"albums": {
>>"href": "https://api.spotify.com/v1/search?query=bat+out+of+hell&offset=0&limit=50&type=album",
>>"items": [


>{
"album_type": "album",
"artists": [
{
"external_urls": {
"spotify": "https://open.spotify.com/artist/7dnB1wSxbYa8CejeVg98hz"
},
"href": "https://api.spotify.com/v1/artists/7dnB1wSxbYa8CejeVg98hz",
"id": "7dnB1wSxbYa8CejeVg98hz",
"name": "Meat Loaf",
"type": "artist",
"uri": "spotify:artist:7dnB1wSxbYa8CejeVg98hz"
}
],
"available_markets": [
"AD",
.......
"US",
"UY"
],
"external_urls": {
"spotify": "https://open.spotify.com/album/6mvI80w5r78niBmwtu7RF9"
},
"href": "https://api.spotify.com/v1/albums/6mvI80w5r78niBmwtu7RF9",
"id": "6mvI80w5r78niBmwtu7RF9",
"images": [
{
"height": 640,
"url": "https://i.scdn.co/image/1bd90a7b9644ec5887549a23dd31d72ce00a05c0",
"width": 640
},
{
"height": 300,
"url": "https://i.scdn.co/image/3e4988282fd7e5bc4a48c380c7d9d0b4296ef078",
"width": 300
},
{
"height": 64,
"url": "https://i.scdn.co/image/86d744fdd911d2db25cf2484e0a925219d8e4a21",
"width": 64
}
],
"name": "Bat Out Of Hell",
"type": "album",
"uri": "spotify:album:6mvI80w5r78niBmwtu7RF9"
},
*/
