//
//  SpotifyTableViewController.swift
//  SpotifySearch
//
//  Created by Victor Zhong on 10/28/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController, UITextFieldDelegate {
	
	var albums = [SpotifyAlbum]()
	var artistDict = [String : Int]()
	var artistArray = [String]()
	
	@IBOutlet weak var searchField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadAlbums()
		self.searchField.delegate = self
	}
	
	internal func loadAlbums(searchString: String = "Meat Loaf") {
		APIRequestManager.manager.getAlbumData(searchString: searchString) { (data) in
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
		artistDict = [String : Int]()
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
		cell.textLabel?.text = albumAtRow.albumName
		cell.detailTextLabel?.text = albumAtRow.artistName
		
		APIRequestManager.manager.downloadImage(urlString: albumAtRow.thumbURL) { (returnedData: Data) in
			DispatchQueue.main.async {
				cell.imageView?.image = UIImage(data: returnedData)
				cell.setNeedsLayout()
			}
		}
		
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
	
	// MARK: - Textfield Stuff
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		if let search = searchField.text {
		loadAlbums(searchString: search)
		}
		
		return true
	}
}
