//
//  SpotifySearchTableViewController.swift
//  SpotifySearch
//
//  Created by John Gabriel Breshears on 10/28/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import UIKit

class SpotifySearchTableViewController: UITableViewController {

    
    var allAlbums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getAlbumData { (data: Data?) in
            if let unwrappedAlbumData = Album.album(from: data!) {
                self.allAlbums = unwrappedAlbumData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
        return allAlbums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) 

        let album = allAlbums[indexPath.row]
        let name = album.albumName
        
        cell.textLabel?.text = name
        
        cell.imageView?.downloadImage(urlString: album.imageUrl)
        
        APIRequestManager.manager.getAlbumData { (data: Data?) in
            if let unwrappedAlbumData = Album.album(from: data!) {
                self.allAlbums = unwrappedAlbumData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }


        
        
        
        
        return cell
    }
}
/*
 let cell = tableView.dequeueReusableCell(withIdentifier: "GiphyCellID", for: indexPath) as! GiphyTableViewCell
     let gif = allGiphies[indexPath.row]
     
     let name = gif.name
     let newName = (name as NSString).replacingOccurrences(of: gif.id, with: "")
     let newname2 = (newName as NSString).replacingOccurrences(of: "-", with: " ")
     
     
     cell.GifNameLabel.text = newname2
     cell.GifStillImage.downloadImage(urlString: gif.urlStillImage)
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
*/
