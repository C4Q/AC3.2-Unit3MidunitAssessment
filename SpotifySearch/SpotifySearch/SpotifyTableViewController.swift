//
//  SpotifyTableViewController.swift
//  SpotifySearch
//
//  Created by Annie Tung on 10/28/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController {
    
    var kaskade = [Kaskade]()

    override func viewDidLoad() {
        super.viewDidLoad()

        APIRequestManager.manager.getSpotifyData(apiEndPoint: "https://api.spotify.com/v1/search?q=automatic&type=album&limit=50") { (data: Data?) in
                if let k = self.validKaskadeData(data: data!) {
                    self.kaskade = k
                    print("*****kaskade info has been populated")
            }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
        }
    }
    
    func validKaskadeData (data: Data) -> [Kaskade]? {
        var k = [Kaskade]()
        
        do{
            let kaskadeData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let kaskadeCasted: [String:Any] = kaskadeData as? [String:Any] else {
                print("*****There was an error casting from String:any at \(kaskadeData)")
                return nil
            }
            print("*****Data was created \(kaskadeData)")
            
            guard let kaskadeArray: [String:Any] = kaskadeCasted["albums"] as? [String:Any] else {
                print("*****There was an error casting from [[String:any]] at \(kaskadeCasted)")
                return nil
            }
            print("*****Array was created \(kaskadeCasted)")
            
            guard let kaskadeItems: [[String:Any]] = kaskadeArray["items"] as? [[String: Any]] else {
                print("*****There was an error casting from String:any at \(kaskadeArray)")
                return nil
            }
            print("*****Valid array was created \(kaskadeItems)")
            
            kaskadeItems.forEach({ kaskadeObject in
                
                guard let albumName: String = kaskadeObject["name"] as? String,
                    
                let artists: [String:Any] = kaskadeObject["artists"]as? [String:Any],
                    let name: String = artists["name"] as? String,
                    
                let imageURL: [String:Any] = kaskadeObject["images"] as? [String:Any],
                    let biggestImage: String = imageURL["url"] as? String,
                    
                let albumURL: [String:Any] = kaskadeObject["external_urls"] as? [String:Any],
                    let spotifyURL: String = albumURL["spotify"] as? String else { return }
                
                print("*****artist casted \(name)")
                print("*****imageURL casted \(imageURL)")
                print("*****album name casted \(albumName)")
                print("*****spotify url casted \(spotifyURL)")
                
                k.append(Kaskade(artistName: name, imageURL: biggestImage, albumName: albumName, spotifyURL: spotifyURL))
            })
            return k
        }
        catch{
            print("*****Error found getting data \(error)")
        }
        return nil
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kaskade.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotifyTableViewCell", for: indexPath)

        let row = kaskade[indexPath.row]
        cell.textLabel?.text = row.artistName
        cell.detailTextLabel?.text = row.albumName
        
        cell.imageView?.image = nil
        
        APIRequestManager.manager.getSpotifyData(apiEndPoint: row.imageURL) { (data: Data?) in
            DispatchQueue.main.async {
                if let d = data {
                    cell.imageView?.image = UIImage(data: d)
                    cell.setNeedsDisplay()
                }
            }
        }
        return cell
    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpotifyIdentifier" {
            if let destination = segue.destination as? SpotifyViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                destination.kas = kaskade[indexPath.row]
            }
            
        }
    }
}
