//
//  AlbumFactory.swift
//  AC3.2-Unit3MidunitAssessment
//
//  Created by Tom Seymour on 10/30/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation

enum SpotifyAlbumParseError: Error {
    case results
    case name(jsonObject: AnyObject)
    case image(jsonObject: AnyObject)
    case artist(jsonObject: AnyObject)
}

class AlbumFactory {
    
    static func buildAlbumArray(from data: Data) -> [Album]? {
        do {
            let spotifyJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            // Cast from Any and check for the "albums" key
            guard let firstDict = spotifyJSONData as? [String: Any],
                let dictOfAlbums = firstDict["albums"] as? [String: Any],
                let arrayOfAlbumDicts = dictOfAlbums["items"] as? [[String: Any]] else { throw SpotifyAlbumParseError.results }
            print("11111111111 got an array of album dicts")
            
            var allTheAlbums: [Album] = []
            
            for albumDict in arrayOfAlbumDicts {
                guard let thisAlbumName = albumDict["name"] as? String else { throw SpotifyAlbumParseError.name(jsonObject: albumDict as AnyObject) }
                
                guard let imageArray = albumDict["images"] as? [[String: Any]] else {  throw SpotifyAlbumParseError.image(jsonObject: albumDict as AnyObject) }
                print("22222222222 got an image array")
                
                let thumbnailString = imageArray.count > 2 ? imageArray[2]["url"] as? String ?? "" : ""
                let mediumString = imageArray.count > 1 ? imageArray[1]["url"] as? String ?? "" : ""
                let fullString = imageArray.count > 0 ? imageArray[0]["url"] as? String ?? "" : ""
                print("333333333333 got image strings")
                
                let theseImages = SetOfImages(thumnail: thumbnailString, medium: mediumString, full: fullString)
                
                guard let artistArray = albumDict["artists"] as? [[String: Any]] else { throw SpotifyAlbumParseError.artist(jsonObject: albumDict as AnyObject) }
                print("44444444444 got an artist array")
                
                let artistName = artistArray.count > 0 ? artistArray[0]["name"] as? String ?? "" : ""
                print("55555555555 got artist string")
                
                let thisAlbum = Album(albumName: thisAlbumName, artistName: artistName, images: theseImages)
                
                allTheAlbums.append(thisAlbum)
            }
            return allTheAlbums
            
        }
        catch SpotifyAlbumParseError.results {
            print("Error occurred while parsing initial JSON data")
        }
        catch let SpotifyAlbumParseError.name(jsonObject) {
            print("Error occurred while parsing data: \(jsonObject)")
        }
        catch let SpotifyAlbumParseError.image(jsonObject) {
            print("Error occurred while parsing data: \(jsonObject)")
        }
        catch let SpotifyAlbumParseError.artist(jsonObject) {
            print("Error occurred while parsing data: \(jsonObject)")
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        return nil
    }

}
