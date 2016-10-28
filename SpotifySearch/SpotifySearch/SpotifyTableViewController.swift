//
//  SpotifyTableViewController.swift
//  SpotifySearch
//
//  Created by Victor Zhong on 10/28/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController {
	
	var albums = [SpotifyAlbum]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadAlbums()
	}
	
	internal func loadAlbums() {
		APIRequestManager.manager.getAlbumData { (data) in
			if data != nil {
				
				if let albums = SpotifyAlbum.albums(from: data!) {
					print("We've got albums! \(albums)")
					
					self.albums = albums
					
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
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
		return albums.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
		let albumAtRow = albums[indexPath.row]
		var image: UIImage?
		var data: Data?
		
		//1. Create a url from the string of the url
		let url = URL(string: albumAtRow.thumbURL)
		
		//2. Create a data object out of the url
		if let unwrappedURL = url {
			data = try? Data(contentsOf: unwrappedURL)
		}
		
		//3. Create an image out of the data object created
		if let realData = data {
			image = UIImage(data: realData)
		}
		
		cell.textLabel?.text = albumAtRow.albumName
		cell.imageView?.image = image
		cell.detailTextLabel?.text = nil
		
		return cell
	}
	
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let tappedAlbumCell: UITableViewCell = sender as? UITableViewCell {
			if segue.identifier == "albumSegue" {
				
				let detailedImage: AlbumImageViewController = segue.destination as! AlbumImageViewController
				
				let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedAlbumCell)!
				
				detailedImage.albumSelected = albums[cellIndexPath.row]
			}
		}
	}
	
}
