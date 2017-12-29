//
//  AlbumCell.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var artworkImg: UIImageView!
    
    func configureCell(album: Album) {
        DataService.instance.getImage(byUrl: album.artworkUrl) { (image) in
            self.artworkImg.image = image
        }
    }
}
