//
//  DataService.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import Foundation
import Alamofire

class DataService {
    static let instance = DataService()
    
    func getAlbums(forSearchText searchText: String, completionHandler: @escaping (_ albums: [Album]) -> ()) {
        
        let searchQuery = searchText.replacingOccurrences(of: " ", with: "+")
        let parameters: Parameters = ["term": searchQuery, "entity": "album"]
        
        request(SEARCH_URL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if let error = response.result.error {
                debugPrint(error)
                return
            }
            
            var albums = [Album]()
            guard let json = response.result.value as? Dictionary<String, Any> else { return }
            let albumsJson = json["results"] as! [Dictionary<String, Any>]
            for item in albumsJson {
                guard let artworkUrl100 = item["artworkUrl100"] as? String else {
                    continue
                }
                
                let albumId = item["collectionId"] as! Int
                let artistName = item["artistName"] as! String
                let albumName = item["collectionName"] as! String
                let country = item["country"] as! String
                let releaseDate = item["releaseDate"] as! String
                let primaryGenreName = item["primaryGenreName"] as? String ?? ""
                
                let album = Album(albumId: albumId, artworkUrl100: artworkUrl100, artistName: artistName, albumName: albumName, country: country, releaseDate: releaseDate, primaryGenreName: primaryGenreName)
                
                albums.append(album)
            }
            albums.sort{$0.albumName < $1.albumName}
            completionHandler(albums)
        }
        
    }
    
    func getSongs(forAlbumId id: Int, completionHandler: @escaping (_ songs: [String]) -> ()) {
        let parameters: Parameters = ["id": id, "entity": "song"]
        request(LOOKUP_URL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if let error = response.result.error {
                debugPrint(error)
                return
            }
            
            var songs = [String]()
            guard let json = response.result.value as? Dictionary<String, Any> else { return }
            let trackList = json["results"] as! [Dictionary<String, Any>]
            for track in trackList {
                guard let trackName = track["trackName"] as? String else {
                    continue
                }
                songs.append(trackName)
            }
            completionHandler(songs)
        }
    }
}
