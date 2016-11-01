//
//  AlbumTableViewController.swift
//  SpotifySearch
//
//  Created by Edward Anchundia on 10/28/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {

    internal let albumTableViewCellIdentifier: String = "AlbumCellIdentifier"
    internal var albums: [Album] = []
    internal let albumEndPoint: String = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getAlbums(apiEndPoint: albumEndPoint) { (albums: [Album]?) in
            if albums != nil {
                    
                DispatchQueue.main.async {
                    self.albums = albums!
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }
    
    func getAlbums(apiEndPoint: String, callback: @escaping ([Album]?) -> Void) {
        if let validAlbumEndPoint: URL = URL(string: apiEndPoint) {
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            session.dataTask(with: validAlbumEndPoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil{
                    print("Error encountered: \(error!)")
                }
                
                if let validData: Data = data {
                    print(validData)
                    
                    let allTheAlbums: [Album]? = AlbumFactory.manager.getAlbums(from: validData)
                    
                    callback(allTheAlbums)
                }
                
            }.resume()
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: albumTableViewCellIdentifier, for: indexPath)

        cell.textLabel?.text = self.albums[indexPath.row].albumName
        cell.detailTextLabel?.text = self.albums[indexPath.row].artistName

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
