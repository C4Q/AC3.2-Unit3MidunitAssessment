//
//  AlbumsTableViewController.swift
//  SpotifySearch
//
//  Created by Tong Lin on 10/28/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController{
    
    internal let apiEndpoint: String = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    internal let detailCellViewIdentifier: String = "detailCellViewIdentifier"
    internal let detailAlbumViewSegue: String = "detailAlbumViewSegue"
    
    internal var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "blue"
        AlbumsManager.makeAlbums(apiEndpoint: apiEndpoint) { (albums: [Album]?) in
            if albums != nil{
                DispatchQueue.main.async {
                    self.albums = albums!
                    self.tableView.reloadData()
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellViewIdentifier, for: indexPath)

        cell.textLabel?.text = albums[indexPath.row].albumName
        cell.detailTextLabel?.text = albums[indexPath.row].artistsName
        
        if let imagedata = try? Data(contentsOf: albums[indexPath.row].cellImageURL){
                cell.imageView?.image = UIImage(data: imagedata)
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tappedAlbumCell: UITableViewCell = sender as? UITableViewCell{
            if segue.identifier == detailAlbumViewSegue{
                
                let albumView: AlbumDetailViewController = segue.destination as! AlbumDetailViewController
                let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedAlbumCell)!
                let album: Album = albums[cellIndexPath.row]
                albumView.album = album
            }
        }
    }

}
