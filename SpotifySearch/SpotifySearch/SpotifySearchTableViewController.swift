//
//  SpotifySearchTableViewController.swift
//  SpotifySearch
//
//  Created by C4Q on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SpotifySearchTableViewController: UITableViewController {
    
    let endpoint = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    var albums: [Album]? = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.manager.getData(endPoint: endpoint) { (data: Data?) in
            if let d = data {
               self.albums = Album.parseData(with: d)
                print(self.albums?.count)

            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        navigationItem.title = "Blue"

    
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
        return albums!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        let currentAlbum = albums![indexPath.row]
        
        cell.textLabel?.text = currentAlbum.albumName
        cell.detailTextLabel?.text = currentAlbum.artistName
        cell.imageView?.image = #imageLiteral(resourceName: "default-placeholder")
        
        APIManager.manager.getData(endPoint: currentAlbum.thumbImageURLString) { (data: Data?) in
            if let d = data {
                DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: d)
                }
            }
        }
        

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "detailSegueID" {
            let cellIndex = self.tableView.indexPath(for: sender as! UITableViewCell)!
            let dvc = segue.destination as! DetailViewController
            
            dvc.albumArtURL = albums![cellIndex.row].fullImageURLString
            dvc.albumName = albums![cellIndex.row].albumName
        }
    }
 

}
