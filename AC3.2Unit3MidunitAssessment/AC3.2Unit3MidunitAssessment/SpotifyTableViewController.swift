//
//  SpotifyTableViewController.swift
//  AC3.2Unit3MidunitAssessment
//
//  Created by Ilmira Estil on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController {
    internal var albums = [Album]()
    internal var images = [String]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpotifyManager.manager.getAlbumData {  (data: Data?) in
            if data != nil {
                if let album = Album.getAlbum(from: data!) {
                    self.albums = album
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        //print(self.albums.count)
                    }
                }
                
                //dump(data)
            }
        }
        
        
    }
    //Get specific image from array of albumimages
    /*
    func getImage() -> [String] {
        var picArr = [String]()
        
        for image in  {
            if Int(image["height"]!)! < 70 {
                picArr.append(image["url"]!)
            } else if Int(image["height"]!)! < 500 && Int(image["height"]!)! > 70 {
                picArr.append(image["url"]!)
            }
        }
        return picArr
    }
    */
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotifyTableViewCell", for: indexPath)
        let selectedCell = self.albums[indexPath.row]
        
        /*
        if let albumCell: SpotifyTableViewCell = cell as? SpotifyTableViewCell {
            albumCell.aTitle.text = selectedCell.albumTitle
            
            return albumCell
        }
        */
        
     
        
        
        // Configure the cell...
        //cell.imageView?.image =
        cell.textLabel?.text = selectedCell.albumTitle
      
        return cell
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
