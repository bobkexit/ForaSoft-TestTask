//
//  ViewController.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit

class SearchAlbumsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet weak var albumCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Variables
    var albums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        albumCollectionView.keyboardDismissMode = .onDrag
    
        searchBar.delegate = self        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: ALBUM_CELL, for: indexPath) as? AlbumCell else {
            return UICollectionViewCell()
        }
        let album = albums[indexPath.item]
        let url = URL(string: album.artworkUrl100)!
        cell.configureCell(url: url)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.item]
        performSegue(withIdentifier: toAlbumInfoVC, sender: album)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toAlbumInfoVC {
            guard let albumInfoVC = segue.destination as? AlbumInfoVC, let album = sender as? Album else{
                return
            }
            albumInfoVC.initData(album: album)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat = 2
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            view.endEditing(true)
            spinner.isHidden = false
            spinner.startAnimating()
            DataService.instance.getAlbums(forSearchText: searchText) { (retrievedAlbums) in
                self.albums = retrievedAlbums;
                self.albumCollectionView.reloadData()
                self.spinner.stopAnimating()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = ""
        DataService.instance.cancelAllRequest()
        albums = []
        albumCollectionView.reloadData()
    }
}

