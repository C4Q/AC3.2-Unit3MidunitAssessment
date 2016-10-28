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
	var artistDict = [String : Int]()
	var artistArray = [String]()
	
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
					
					self.countArtists()
					
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				}
			}
		}
	}
	
	func countArtists() {
		for album in albums {
			artistDict[album.artistName] = 1
		}
		
		artistArray = Array(artistDict.keys).sorted { $0 < $1 }
		print("\n\n\nArtist dict: \(artistDict.count)")
		print("\nArtist Array: \(artistArray)")
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		print("\nArtist Count: \(artistArray.count)")
		return artistArray.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let albumsByArtist = albums.filter { (album) -> Bool in
			(album.artistName) == artistArray[section]
		}
		return albumsByArtist.count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "\(artistArray[section])"
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
		
		let albumsByArtist = albums.filter { (album) -> Bool in
			(album.artistName) == artistArray[indexPath.section]
		}
		
		let albumAtRow = albumsByArtist.sorted() { $0.albumName < $1.albumName } [indexPath.row]

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
		cell.detailTextLabel?.text = albumAtRow.artistName
		cell.imageView?.image = image
		
		return cell
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let tappedAlbumCell: UITableViewCell = sender as? UITableViewCell {
			if segue.identifier == "albumSegue" {
				
				let detailedImage: AlbumImageViewController = segue.destination as! AlbumImageViewController
				
				let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedAlbumCell)!
				
				let albumsByArtist = albums.filter { (album) -> Bool in
					(album.artistName) == artistArray[cellIndexPath.section]
				}
				
				let albumAtRow = albumsByArtist.sorted() { $0.albumName < $1.albumName } [cellIndexPath.row]
			
				detailedImage.albumSelected = albumAtRow
			}
		}
	}
	
}
