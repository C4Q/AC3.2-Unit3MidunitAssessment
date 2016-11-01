//
//  AlbumTableViewController.swift
//  SpotifyApp
//
//  Created by Eashir Arafat on 10/28/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController {
   
    internal let AlbumJSONFileName: String = "SpotifyAlbums.json"
    internal var Albums: [Album] = []
    
    internal let AlbumEndpoint: String = "https://api.spotify.com/v1/search?q=blue&type=album&limit=50"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAlbums(from: AlbumEndpoint)
    }
     
    func getAlbums(from apiEndpoint: String) { // <<< returns Void
        if let validAlbumEndpoint: URL = URL(string: apiEndpoint) {
            
            // 1. URLSession/Configuration
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // 2. dataTaskWithURL
            session.dataTask(with: validAlbumEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
                // 3. check for errors right away
                if error != nil {
                    print("Error encountered!: \(error!)")
                }
                
                // 4. printing out the data
                if let validData: Data = data {
                    print(validData)
                    
                   
                    if let Albums: [Album] = AlbumFactory.manager.getAlbums(from: validData) {
                        self.Albums = Albums
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                        
                    }
                }
                }.resume() 
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCellIdentifier", for: indexPath)
      
        cell.textLabel?.text = self.Albums[indexPath.row].albumName
        
        return cell
    }
    
    
    
}
