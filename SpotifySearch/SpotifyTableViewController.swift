//
//  SpotifyTableViewController.swift
//  SpotifySearch
//
//  Created by Margaret Ikeda on 10/28/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import UIKit
internal let SpotifyTableViewCellIdentifier: String = "SpotifyCell"
internal let SpotifyJsonFileName: String = "Spotify.json"
internal var Spotify: [SpotifySearch] = []

internal let SpotifyEndpoint: String = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"

class SpotifyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SpotifySearchFactory.makeSpotifySearch(apiEndpoint: SpotifyEndpoint) { (spotify: [SpotifySearch]?) in
            if spotify != nil {
                for search in SpotifySearch! {
                    print(search.name)
                }
                
                self.SpotifySearch = SpotifySearch!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.spotify.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)


        return cell
    }
    */

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
