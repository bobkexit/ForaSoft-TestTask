//
//  AlbumCell.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit
import AlamofireImage

class AlbumCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var artworkImg: UIImageView!
    
    func configureCell(url: URL) {
        self.artworkImg.af_setImage(withURL: url)
    }
}
