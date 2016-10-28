//
//  AlbumsTableViewController.swift
//  AC3.2-Unit3MidunitAssessment
//
//  Created by Tom Seymour on 10/28/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albums = [Album]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableViewData()
    }

    func loadTableViewData() {
        APIHelper.manager.getData(endPoint: APIHelper.manager.endPoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            self.albums = Album.buildAlbumArray(from: unwrappedData)!
            
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
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCellIdentifyer", for: indexPath)
        let thisAlbum = albums[indexPath.row]
        cell.textLabel?.text = thisAlbum.albumName
        
        APIHelper.manager.downloadImage(urlString: thisAlbum.Images.thumnail) { (returnedData: Data) in
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: returnedData)
                cell.setNeedsLayout()
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisAlbum  = albums[indexPath.row]
        performSegue(withIdentifier: "AlbumDetailPageSegue", sender: thisAlbum)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlbumDetailPageSegue" {
            if let destiationVC = segue.destination as? AlbumDetailViewController {
                destiationVC.thisAlbum = sender as? Album
            }
        }
        

    }
    


}
