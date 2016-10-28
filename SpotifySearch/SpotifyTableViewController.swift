//
//  SpotifyTableViewController.swift
//  SpotifySearch
//
//  Created by Marcel Chaucer on 10/28/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController {
    var apiEndPoint = "https://api.spotify.com/v1/search?q=Nas&type=album&limit=30"
    var theAlbums: [Album] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AlbumFactory.manager.getAlbums(from: apiEndPoint, callback: {(albums: [Album]?) in
            if let theseAlbums = albums {
                self.theAlbums = theseAlbums
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.title = "Nas"
                }
            }
            
            })
    }

        // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return theAlbums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath)
        let url = URL(string: theAlbums[indexPath.row].thumbNailPic)
        let data = try? Data(contentsOf: url!)
        
        
        cell.textLabel?.text = theAlbums[indexPath.row].albumTitle
        cell.imageView?.image = UIImage(data: data!)
        
        return cell
    }
    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbumArt" {
            if let destination = segue.destination as? SpotifyDetailsViewController {
                destination.albumArt =  sender as? Album
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = self.theAlbums[indexPath.row]
        performSegue(withIdentifier: "showAlbumArt", sender: selectedAlbum)
    }
    

}
