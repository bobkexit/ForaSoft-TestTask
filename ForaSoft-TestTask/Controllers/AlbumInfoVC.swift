//
//  AlbumInfoVC.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit
class AlbumInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var artworkImg: UIImageView!
    @IBOutlet weak var albumNameLbl: UILabel!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //Variables
    public private(set) var album: Album?
    private var songs = [String]()
    
    func initData(album: Album) {
        self.album = album
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let album = album {
            albumNameLbl.text = album.albumName
            artistNameLbl.text = album.artistName
            countryLbl.text = album.country
            genreLbl.text = album.primaryGenreName
            //dirty way to get year part, but more simple instead of convert to date and back to string
            releaseDateLbl.text = album.releaseDate.components(separatedBy: "-")[0] 
            
            let url = URL(string: album.artworkUrl100)!
            artworkImg.af_setImage(withURL: url)
            
            spinner.isHidden = false
            spinner.stopAnimating()
            DataService.instance.getSongs(forAlbumId: album.albumId, completionHandler: { (retrievedSongs) in
                self.songs = retrievedSongs;
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            })
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SONG_CELL, for: indexPath) as? SongCell else {
            return UITableViewCell()
        }
        let trackName = songs[indexPath.row]
        cell.configureCell(trackName: trackName)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

}
