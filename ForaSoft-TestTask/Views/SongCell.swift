//
//  SongCell.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var trackName: UILabel!
    
    func configureCell(trackName: String) {
       self.trackName.text = trackName
    }

}
