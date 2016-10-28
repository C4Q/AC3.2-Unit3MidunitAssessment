//
//  SpotifySearchTableViewController.swift
//  SpotifySearch
//
//  Created by Sabrina Ip on 10/28/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import UIKit

class SpotifySearchTableViewController: UITableViewController {
    
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Blue"
        APIRequestManager.manager.getSearchData { (data: Data?) in
            if let unwrappedSearchData = Album.getAlbum(from: data!) {
                self.albums = unwrappedSearchData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        let album = albums[indexPath.row]
        cell.albumNameLabel.text = album.albumName
        cell.thumbnailImage.downloadImage(urlString: album.imageThumbnail)
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbum" {
            if let dest = segue.destination as? AlbumDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                dest.albumSelected = albums[indexPath.row]
            }
        }
    }
}
