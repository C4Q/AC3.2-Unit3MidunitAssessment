//
//  SpotifyAlbumsTableViewController.swift
//  SpotifySearch
//
//  Created by Karen Fuentes on 10/28/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class SpotifyAlbumsTableViewController: UITableViewController {
    internal var spotifyAlbumArray = [SpotifyAlbum]()
    var selectedSpotifyAlbum: SpotifyAlbum?

    override func viewDidLoad() {
        super.viewDidLoad()
        SpotifyApiManager.manager.getSpotifyJsonData { (data:Data?) in
            if data != nil {
                if let spotifyData = SpotifyAlbum.spotifyJsonDataToArrayofSpotify(from: data!) {
                    self.spotifyAlbumArray = spotifyData
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return spotifyAlbumArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotifyTableViewCell", for: indexPath) as! SpotifyAlbumTableViewCell

        //cell.textLabel?.text = spotifyAlbumArray[indexPath.row].title
        cell.spotifyAlbumTitle.text = spotifyAlbumArray[indexPath.row].title
        cell.imageView?.downloadImage(urlString: spotifyAlbumArray[indexPath.row].thumbImage)
    

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSpotifyAlbum = spotifyAlbumArray[indexPath.row]
        performSegue(withIdentifier: "spotifyAlbumImageSegue", sender: selectedSpotifyAlbum)
    }

  

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "spotifyAlbumImageSegue" {
            if let destination = segue.destination as? SpotifyAlbumImageViewController {
                destination.selectedAlbum = sender as! SpotifyAlbum? 
            }
        }
    }


}
