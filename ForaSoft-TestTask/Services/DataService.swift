//
//  DataService.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DataService {
    static let instance = DataService()
    
    func getAlbums(forSearchText searchText: String, completionHandler: @escaping (_ albums: [Album]) -> ()) {
        
        let searchQuery = searchText.replacingOccurrences(of: " ", with: "+")
        let parameters: Parameters = ["term": searchQuery, "entity": "album"]
        
        request(BASE_URL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        
            var albums = [Album]()
            if let error = response.result.error {
                debugPrint(error) //TODO: do something with error
                completionHandler(albums)
            }
            guard let json = response.result.value as? Dictionary<String, Any> else { return }
            let albumsJson = json["results"] as! [Dictionary<String, Any>]
            for item in albumsJson {
                let albumId = String(describing: item["collectionId"])
                let artworkUrl = item["artworkUrl60"] as! String //TODO: catch error
                let album = Album(albumId: albumId, artworkUrl: artworkUrl)
                albums.append(album)
            }
            completionHandler(albums)
        }
        
    }
    
    func getImage(byUrl url: String, completionHandler: @escaping (_ image: UIImage) -> ()) {
        Alamofire.request(url).responseImage { (response) in
            if let error = response.result.error {
                debugPrint(error) //TODO: do something with error
            } else {
                guard let image = response.result.value else { return }
                completionHandler(image)
            }
        }
    }
}
