//
//  SpotifyAlbumsTableViewController.swift
//  unit3MidUnitAssessment
//
//  Created by Erica Y Stevens on 10/29/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class SpotifyAlbumsTableViewController: UITableViewController {
    
    internal let query = "Beyoncè"
    internal let spotifyEndpoint: String = "https://api.spotify.com/v1/search?q=beyonce&type=album&limit=50"
    internal var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = query
        
        self.getAlbumsfromSpotify(apiEndpoint: spotifyEndpoint) { (albums: [Album]?) in
            if albums != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.albums = albums!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albums.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        
        // Configure the cell...
        let album = albums[indexPath.row]
        
        cell.albumTitleLabel.text = album.title
        cell.albumCoverImageView.loadImageUsing(url: album.smallestImageURL)
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailViewController {
            if let cell = sender as? AlbumTableViewCell {
                if let indexPath = self.tableView.indexPath(for: cell) {
                    let album = albums[indexPath.row]
                    vc.imageURL = String(describing: album.largestImageURL)
                    vc.title = album.title
                }
            }
        }
    }
    
    
    // MARK: - API REQUEST
    
    func getAlbumsfromSpotify(apiEndpoint: String, callback: @escaping ([Album]?) -> Void) {
        
        //Try to conver apiEndpoint from String to URL
        if let validAlbumURL = URL(string: apiEndpoint){
            
            //URLSession/Configuration
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            //Data Task with URL
            session.dataTask(with: validAlbumURL) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
                
                //Immediate Error Check
                if error != nil {
                    print("Error encountered: \(error)")
                }
                
                if let validData: Data = data {
                    if let albums: [Album] = AlbumFactory.manager.getAlbums(from: validData) {
                        //print(albums)
                        callback(albums)
                    }
                }
                }.resume() //Launches data task
        }else {
            print("String was not able to be converted into an URL")
        }
    }
    
}
