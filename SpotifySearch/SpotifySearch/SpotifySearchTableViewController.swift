//
//  SpotifySearchTableViewController.swift
//  SpotifySearch
//
//  Created by Kadell on 10/28/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import UIKit

enum param: String {
    case parameter = "orange"
}


class SpotifySearchTableViewController: UITableViewController {
    
    var albumsAll: [Albums] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = param.parameter.rawValue.uppercased()
        APIRequestManager.getURL(apiEndPoint: "https://api.spotify.com/v1/search?q=\(param.parameter.rawValue)&type=album&limit=50") { (data: Data?) in
            if data != nil {
                if let new = Albums.eachAlbum(data: data!) {
                    self.albumsAll = new
             
                }
                DispatchQueue.main.async {
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.albumsAll.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Album Cell", for: indexPath)

        cell.textLabel?.text = albumsAll[indexPath.row].nameOfAlbum
        
        APIRequestManager.getURL(apiEndPoint: albumsAll[indexPath.row].thumbnailImage) { (data: Data?) in
            if let newdata = data {
                cell.imageView?.image = UIImage(data: newdata)
            }
            
            DispatchQueue.main.async {
            cell.setNeedsLayout()
            }

        }

        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "spotifySearchDetail", let anAlbum = sender as? Albums {
            let albumController = segue.destination as! ViewController
            albumController.moreAlbums = anAlbum
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = albumsAll[indexPath.row]
        performSegue(withIdentifier: "spotifySearchDetail", sender: selectedAlbum)
        
    }


}
