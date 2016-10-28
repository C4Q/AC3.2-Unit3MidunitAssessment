//
//  AlbumTableViewController.swift
//  SpotifySearch
//
//  Created by Harichandan Singh on 10/28/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {
    //MARK: - Properties
    internal var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = Array(APIRequestManager.manager.apiEndpoint.characters)
        self.title = String(array[36...47])
        
        loadAlbums()
    }
    
    func loadAlbums() {
        APIRequestManager.manager.getData(apiEndpoint: APIRequestManager.manager.apiEndpoint) { (data: Data?) in
            if data != nil {
                if let x = Album.createSpotifyObject(from: data!) {
                    self.albums = x
                    print("The albums array has been populated!")
                }
            }
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
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> AlbumTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell
        let album = albums[indexPath.row]
        cell?.titleLabel.text = album.title
        
        APIRequestManager.manager.getData(apiEndpoint: album.thumbnailImageString) { (data: Data?) in
            if let d = data {
                cell?.thumbnailImage.image = UIImage(data: d)
            }
            DispatchQueue.main.async {
                self.tableView.setNeedsLayout()
            }
        }
        return cell!
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
        if let cell = sender as? AlbumTableViewCell {
            let indexPath = tableView.indexPath(for: cell)
            let album = albums[(indexPath?.row)!]
            if segue.identifier == "albumSegue" {
                if let dvc = segue.destination as? DetailViewController {
                    dvc.title = album.title
                    dvc.fullSizeImageString = album.fullSizeImageString
                }
            }
        }
     }
    
}
