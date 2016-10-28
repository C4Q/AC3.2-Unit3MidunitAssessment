//
//  SpotifySearchTableViewController.swift
//  SpotifySearch
//
//  Created by C4Q on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SpotifySearchTableViewController: UITableViewController, UITextFieldDelegate {
    
    var albums: [Album]? = []
    
    @IBOutlet weak var albumOrArtist: UISegmentedControl!
    @IBOutlet weak var searchInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.manager.getData(endPoint: APIManager.manager.endPoint) { (data: Data?) in
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
        return albums?.count ?? 0
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let term = searchInput.text {
            APIManager.manager.upDateEndPoint(term: term)
            
            APIManager.manager.getData(endPoint: APIManager.manager.endPoint) { (data: Data?) in
                if let d = data {
                    self.albums = Album.parseData(with: d)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
        return true
    }// called when 'return' key pressed. return NO to ignore.
    
    
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
