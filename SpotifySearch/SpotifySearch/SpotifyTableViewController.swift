//
//  SpotifyTableViewController.swift
//  SpotifySearch
//
//  Created by Madushani Lekam Wasam Liyanage on 10/28/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController {

    
    internal let SpotifyTableViewCellIdentifier: String = "SpotifyCellIdentifier"
    internal var playList: [PlayList] = []
    internal let playListEndpoint: String = "https://api.spotify.com/v1/search?q=Taylor&type=album&limit=50"
    var selectedPlayList: PlayList?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let searchNameArray = playListEndpoint.components(separatedBy: "https://api.spotify.com/v1/search?q=")
        let secondpart = searchNameArray[1]
        let next = secondpart.components(separatedBy: "&type=")
        let part1 = next[0]
        let next2 = next[1].components(separatedBy: "&limit=50")
        let part2 = next2[0]
        
        self.title = part1 + " " + part2
        
        
        print(next2)
        PlayListFactory.makePlayList(apiEndpoint: playListEndpoint) { (returnedPlayList: [PlayList]?) in
            if let unwrappedReturnedPlayList = returnedPlayList {
                self.playList = unwrappedReturnedPlayList
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
        return playList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SpotifyTableViewCellIdentifier, for: indexPath)

       cell.textLabel?.text = playList[indexPath.row].title
       let urlString = playList[indexPath.row].thumbnailImageString
        cell.imageView?.downloadImage(urlString: urlString)

        return cell
    }
    

  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPlayList = self.playList[indexPath.row]
        performSegue(withIdentifier: "SpotifyViewIdentifier", sender: selectedPlayList)
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpotifyViewIdentifier" {
            if let sdvc = segue.destination as? SpotifyDetailViewController {
                sdvc.playList = selectedPlayList
            }
            
            
        }
    }

}
