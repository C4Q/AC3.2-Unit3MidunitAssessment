//
//  CellController.swift
//  SpotifySearch
//
//  Created by Marty Avedon on 10/28/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class CellController: UITableViewController {

    var albumArr: [Albums]? = [Albums]()
    var chosenAlbum: Albums?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Albums"//we need to alter this to represent the search term from the URL in something resembling English...we could be a punk and hardcode it but that would not be sporting
        
        AlbumFactory.RCA.getData {(data: Data?) in
            dump(self.albumArr)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArr!.count //problems binding [Albums]...so we're forcing it. Bad.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eachAlbum", for: indexPath)
        
        // Adding content to cell
        
        let thisCellsAlbum = self.albumArr?[indexPath.row]
        
        // Configure the cell...
        
        cell.textLabel?.text = /*"ASDsccsdcw"*/ thisCellsAlbum?.title // this calls up the main text label -- in this case, the one named title in the storyboard. we may think we're "creating" the label but it's already waiting for us. this is more clear when we use a basic or detail cell style. we just don't have to create an outlet for it using control-drag, which is a little confusing
        // cell.detailTextLabel?.text = thisCAlbum.???? // convert this into image
        
        // Styling
        
        cell.textLabel?.font = UIFont(name: "Futura", size: 16)

        return cell
    }
 

 


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "showArt",
            let goHere = segue.destination as? AlbumArtController,
        // Pass the selected object to the new view controller.
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
                let albumUserPicked = self.albumArr?[indexPath.row]
                goHere.chosenAlbum = albumUserPicked
            }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        if segue.identifier == "episodeSegue",
//            let destination = segue.destination as? EpisodeDeetsController,
//            // Pass the selected object to the new view controller.
//            let cell = sender as? UITableViewCell,
//            let ip = tableView.indexPath(for: cell) {
//            let ep = self.episodes[ip.row]
//            destination.chosenEpisode = ep
//        }
//    }

}
