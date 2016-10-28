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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "KPopDetailViewSegue" {
            let KPopDetailViewController = segue.destination as? KPopDetailViewController
            let selectedAlbum = sender as? Album
            KPopDetailViewController?.album = selectedAlbum
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
    
}
