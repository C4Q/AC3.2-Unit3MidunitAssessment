//
//  AlbumsManager.swift
//  SpotifySearch
//
//  Created by Tong Lin on 10/28/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import Foundation

class AlbumsManager{
    static let manager: AlbumsManager = AlbumsManager()
    private init() {}
    
    class func makeAlbums(apiEndpoint: String, callback: @escaping ([Album]?) -> Void){
        if let albumsURL: URL = URL(string: apiEndpoint){
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: albumsURL){ (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil{
                    print(error!)
                }
                
                if let dogsData: Data = data {
                    print(dogsData)
                    if let albums: [Album] = AlbumsManager.manager.getAlbums(from: dogsData){
                        dump(albums)
                        callback(albums)
                    }
                }
                }.resume()
        }
    }
    
    internal func getAlbums(from jsonData: Data) -> [Album]?{
        do {
            let albumsData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            guard let tempData: [String: AnyObject] = albumsData as? [String: AnyObject],
                let albumsCasted: [String: AnyObject] = tempData["albums"] as? [String: AnyObject],
                let albumsArr: [AnyObject] = albumsCasted["items"] as? [AnyObject] else {
                    return nil
            }
            
            var albums: [Album] = []
            albumsArr.forEach({ albumObject in
                guard let albumName: String = albumObject["name"] as? String,
                    let artists: [Any] = albumObject["artists"] as? [Any],
                    let images: [Any] = albumObject["images"] as? [Any],
                    let id: String = albumObject["id"] as? String  else{
                        return
                }
                
                guard let artistsDetail: [String: Any] = artists[0] as? [String: Any],
                    let artistsName: String = artistsDetail["name"] as? String else{
                        return
                }
                
                guard let smallImage: [String: Any] = images[2] as? [String: Any],
                    let cellImageString: String = smallImage["url"] as? String else{
                        return
                }
                
                guard let largeImage: [String: Any] = images[0] as? [String: Any],
                    let detailImageString: String = largeImage["url"] as? String else{
                        return
                }
                    
                let cellImageURL: URL = URL(string: cellImageString)!
                let detailImageURL: URL = URL(string: detailImageString)!
                let spotifyURL: URL = URL(string: "https://open.spotify.com/album/\(id)")!
                
                albums.append(Album.init(albumName: albumName, artistsName: artistsName, cellImageURL: cellImageURL, detailImageURL: detailImageURL, spotifyURL: spotifyURL))
            })
            return albums
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
}
