//
//  Album.swift
//  ForaSoft-TestTask
//
//  Created by Николай Маторин on 29.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import Foundation

struct Album {
    public private(set) var albumId: Int!
    public private(set) var artworkUrl100: String!
    public private(set) var artistName: String!
    public private(set) var albumName: String!
    public private(set) var country: String!
    public private(set) var releaseDate: String!
    public private(set) var primaryGenreName: String?
}
