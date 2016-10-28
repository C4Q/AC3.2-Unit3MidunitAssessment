//
//  AlbumsTableViewController.swift
//  SpotifySearch
//
//  Created by Jermaine Kelly on 10/28/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let AlbumsEndpoint: String = "https://api.spotify.com/v1/search?q=red&type=album&limit=50"
    var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .green
        
        self.title = "Spotify Search"
        APIRequestManager.manager.getData(from: AlbumsEndpoint) { (data) in
            guard let validData = data else{ return}
            guard let validAlbums = Album.createObj(data: validData) else {return}
            
            self.albums = validAlbums
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.cellIdentifier, for: indexPath) as! AlbumTableViewCell
        
        let album: Album = albums[indexPath.row]

        cell.albumNameLabel.text = album.name
        cell.artistNameLabel.text = "By: \(album.artist)"
        cell.albumCoverImageView.downloadImage(from: album.image)
            


        return cell
    }
 
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let albumDetailsVC = segue.destination as? AlbumDetailsViewController else {return}
        if segue.identifier == "AblumDetails"{
            guard let cellIndex = tableView.indexPathForSelectedRow else {return}
            albumDetailsVC.album = albums[cellIndex.row]
        }
    
    }
    
    
    

}
