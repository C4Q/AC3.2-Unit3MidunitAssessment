//
//  Album.swift
//  AC3.2-Unit3MidunitAssessment
//
//  Created by Tom Seymour on 10/28/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation

enum SpotifyAlbumParseError: Error {
    case albums, name, location, login, id, picture
    case email(json: AnyObject)
}

struct SetOfImages {
    let thumnail: String
    let medium: String
    let full: String
}

class Album {
    let albumName: String
    let artistName: String
    let Images: SetOfImages
    
    init(albumName: String, artistName: String, images: SetOfImages) {
        self.albumName = albumName
        self.artistName = artistName
        self.Images = images
    }
    
    static func buildAlbumArray(from data: Data) -> [Album]? {
        do {
            let spotifyJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            // Cast from Any and check for the "albums" key
            guard let firstDict = spotifyJSONData as? [String: Any] else { return nil }
            print("111111111 got first dictionary")
            guard let dictOfAlbums = firstDict["albums"] as? [String: Any] else { return nil }
            print("222222222 got a dictionary of albums")
            guard let arrayOfAlbumDicts = dictOfAlbums["items"] as? [[String: Any]] else { return nil }
            print("333333333 got an array of album dicts")
            
            var allTheAlbums: [Album] = []
            
            for albumDict in arrayOfAlbumDicts {
                guard let thisAlbumName = albumDict["name"] as? String else { return nil }
                print("444444444 got an album name")
                
                guard let imageArray = albumDict["images"] as? [[String: Any]] else { return nil }
                print("555555555 got an image array")
                
                var thumbnailString: String = ""
                var mediumString: String = ""
                var fullString: String = ""
                
                if imageArray.count > 2 {
                    thumbnailString = imageArray[2]["url"] as? String ?? ""
                }
                if imageArray.count > 1 {
                    mediumString = imageArray[1]["url"] as? String ?? ""
                }
                if imageArray.count > 0 {
                    fullString = imageArray[0]["url"] as? String ?? ""
                }
                
                print("6666666666 got image strings")
                
                let theseImages = SetOfImages(thumnail: thumbnailString, medium: mediumString, full: fullString)
                
                guard let artistArray = albumDict["artists"] as? [[String: Any]] else { return nil }
                print("7777777777 got an artist array")
                guard let artistName = artistArray[0]["name"] as? String else { return nil}
                print("888888888 got artist string")

                let thisAlbum = Album(albumName: thisAlbumName, artistName: artistName, images: theseImages)
                
                allTheAlbums.append(thisAlbum)
            }
            return allTheAlbums
            
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return nil
    }

}
