//
//  AlbumFactory.swift
//  AC3.2-Albums-2
//
//  Created by Louis Tur on 10/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit


/// Used to create `[Album]`
class AlbumFactory {
    
    static let manager: AlbumFactory = AlbumFactory()
    private init() {}
    
    
    /// Attempts to make `[Album]` from the `Data` contained in a local file
    /// - parameter filename: The name of the file containing json-formatted data, including its extension in the name
    /// - returns: An array of `Album` if the file is located and has properly formatted data. `nil` otherwise.
    class func makeAlbums(fileName: String) -> [Album]? {
        
        // Everything from viewDidLoad in AlbumTableViewController has just been moved here
        guard let AlbumsURL: URL = AlbumFactory.manager.getResourceURL(from: fileName),
            let AlbumData: Data = AlbumFactory.manager.getData(from: AlbumsURL),
            let AlbumsAll: [Album] = AlbumFactory.manager.getAlbums(from: AlbumData) else {
                return nil
        }
        
        return AlbumsAll
    }
    
    
    /// Gets the `URL` for a local file
    fileprivate func getResourceURL(from fileName: String) -> URL? {
        
        guard let dotRange = fileName.rangeOfCharacter(from: CharacterSet.init(charactersIn: ".")) else {
            return nil
        }
        
        let fileNameComponent: String = fileName.substring(to: dotRange.lowerBound)
        let fileExtenstionComponent: String = fileName.substring(from: dotRange.upperBound)
        
        let fileURL: URL? = Bundle.main.url(forResource: fileNameComponent, withExtension: fileExtenstionComponent)
        
        return fileURL
    }
    
    /// Gets the `Data` from the local file located at a specified `URL`
    fileprivate func getData(from url: URL) -> Data? {
        
        let fileData: Data? = try? Data(contentsOf: url)
        return fileData
    }
    
    
    // MARK: - Data Parsing
    /// Creates `[Album]` from valid `Data`
    internal func getAlbums(from jsonData: Data) -> [Album]? {
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: jsonData, options: [])
            guard let jsonUnwrapped = jsonData as? [String: Any]
                else {
                    print("JSON error")
                    return nil
            }
            
            guard let albumsUnwrapped = jsonUnwrapped["albums"] as? [String:Any]
                else {
                    print("Albums error")
                    return nil
            }
            
            guard let itemsUnwrapped = albumsUnwrapped["items"] as? [[String: Any]]
                else {
                    print("Items error")
                    return nil
            }
            
            var Albums: [Album] = []

            for albumDictionary in itemsUnwrapped {
                guard let albumName = albumDictionary["name"] as? String else {
                    print("Album name error")
                    
                    return nil
                }
                Albums.append(Album(albumName: albumName))
                
            }
            
            return Albums
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return  nil
    }
    
}
