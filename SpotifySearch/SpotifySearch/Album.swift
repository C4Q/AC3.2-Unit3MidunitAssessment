//
//  Spotify.swift
//  SpotifySearch
//
//  Created by Harichandan Singh on 10/28/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

enum SpotifyError: Error {
    case titleError, itemsError, imagesArrayError
}

internal struct Album {
    //MARK: - Properties
    internal let title: String
    internal let thumbnailImageString: String
    internal let fullSizeImageString: String
    
    //MARK: - Methods
    static func createSpotifyObject(from data: Data) -> [Album]? {
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let spotifyDict = jsonData as? [String: Any] else {
                print("There was an error casting from jsonData: \(jsonData)")
                return nil
            }
            
            guard let albumDict = spotifyDict["albums"] as? [String: Any] else {
                print("There was an error casting from spotifyDict: \(spotifyDict)")
                return nil
            }
            print("Successfully casted data into albumDict: \(albumDict)")
            
            var allAlbums: [Album] = []
            
            guard let itemsArray = albumDict["items"] as? [[String: Any]] else {
                throw SpotifyError.titleError
            }
            
            for dict in itemsArray {
                guard let title = dict["name"] as? String else {
                    throw SpotifyError.itemsError
                }
                
                guard let imagesArray = dict["images"] as? [[String: Any]] else {
                    throw SpotifyError.imagesArrayError
                }
                
                let thumbnailImageURL = imagesArray.count == 0 ? "" : imagesArray[2]["url"] as! String
                let fullSizeImageURL = imagesArray.count == 0 ? "" : imagesArray[0]["url"] as! String
                
                let album: Album = Album(title: title, thumbnailImageString: thumbnailImageURL, fullSizeImageString: fullSizeImageURL)
                allAlbums.append(album)
            }
            return allAlbums
        }
        catch SpotifyError.itemsError {
            print("There was an error finding the items key.")
        }
        catch SpotifyError.titleError {
            print("There was an error finding the name key.")
        }
        catch SpotifyError.imagesArrayError {
            print("There was an error finding the images key.")
        }
        catch {
            print("ERROR ENCOUNTERED.")
        }
        return nil
    }
}
