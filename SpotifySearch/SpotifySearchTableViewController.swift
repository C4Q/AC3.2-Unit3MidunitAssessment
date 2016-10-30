//
//  SpotifySearchTableViewController.swift
//  SpotifySearch
//
//  Created by Ana Ma on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SpotifySearchTableViewController: UITableViewController {
    
    var album = [Album]()
    
    
    var apiEndpoint = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    var anotherEndpoint = "https://api.spotify.com/v1/search?q=kpop&type=album&limit=50"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Blue"
        
        APImanager.getData(endpoint: apiEndpoint) { (data: Data?) in
            if data != nil {
                if let album = Album.getAlbum(data: data!) {
                    self.album = album
                }
                //dump(data)
            }
            
            //dump(self.album)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        return album.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCellIdentifier", for: indexPath)
        cell.textLabel?.text = album[indexPath.row].title
        
        APImanager.getData(endpoint: album[indexPath.row].imageThumbURLString) { (data) in
            DispatchQueue.main.async {
                if data != nil {
                    cell.imageView?.image = UIImage(data: data!)
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = self.album[indexPath.row]
        performSegue(withIdentifier: "detailAlbumViewSegue" , sender: selectedAlbum )
    }
    

     // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailAlbumViewSegue" {
            let detailAlbumViewController = segue.destination as? DetailAlbumViewController
            let selectedAlbum = sender as? Album
            detailAlbumViewController?.album = selectedAlbum
        }
     }
}
