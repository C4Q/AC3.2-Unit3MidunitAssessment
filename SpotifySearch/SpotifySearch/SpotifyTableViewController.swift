//
//  SpotifyTableViewController.swift
//  SpotifySearch
//
//  Created by Thinley Dorjee on 10/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController {

    var spotifies = [Spotify]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        self.title = "PlayList"
    }
    
    func loadData(){
        SpotifyAPIFactory.manager.getSpotifyData { (validData: Data?) in
            guard let unwrappedSpotifyData = validData else {return}
            self.spotifies = Spotify.buildSpotifyArray(from: unwrappedSpotifyData)!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return spotifies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotifyTableViewCellIdentifier", for: indexPath)

        cell.textLabel?.text = spotifies[indexPath.row].name


        return cell
    }
    
    override func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        let thisCell = spotifies[indexPath.row]
        performSegue(withIdentifier: "SpotifyTableViewCellIdentifier", sender: thisCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showView"{
            if let destinationVc = segue.destination as? DetailViewController{
                destinationVc.detailImage = sender as? Spotify
            }
        }
    }
}
