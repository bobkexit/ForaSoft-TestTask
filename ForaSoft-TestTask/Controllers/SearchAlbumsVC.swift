//
//  ViewController.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit

class SearchAlbumsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet weak var albumCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Variables
    var albums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        searchBar.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: ALBUM_CELL, for: indexPath) as? AlbumCell else {
            return UICollectionViewCell()
        }
        let album = albums[indexPath.item]
        cell.configureCell(album: album)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            view.endEditing(true)
            DataService.instance.getAlbums(forSearchText: searchText) { (retrievedAlbums) in
                self.albums = retrievedAlbums;
                self.albumCollectionView.reloadData()
            }
        }
    }
    
}

