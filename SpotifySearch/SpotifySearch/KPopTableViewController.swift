//
//  GEMTableViewController.swift
//  SpotifySearch
//
//  Created by Ana Ma on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class KPopTableViewController: UITableViewController {

    var album = [Album]()
    
    var anotherEndpoint = "https://api.spotify.com/v1/search?q=kpop&type=album&limit=50"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "K-Pop"
        
        APImanager.getData(endpoint: anotherEndpoint) { (data: Data?) in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "kpopCellIdentifier", for: indexPath)
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
        performSegue(withIdentifier: "KPopDetailViewSegue" , sender: selectedAlbum )
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "KPopDetailViewSegue" {
            let KPopDetailViewController = segue.destination as? KPopDetailViewController
            let selectedAlbum = sender as? Album
            KPopDetailViewController?.album = selectedAlbum
        }
    }
}
