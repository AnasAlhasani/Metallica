//
//  Album.swift
//  Metallica
//
//  Created by Anas on 9/26/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

struct Album {
    
    var image: UIImage
    var title: String
    var date: String
    
    private init(image: UIImage, title: String, date: String) {
        self.image = image
        self.title = title
        self.date = date
    }
    
    private init?(dictionary: [String: String]) {
        guard let title = dictionary["Title"],
            let date = dictionary["Date"],
            let imageName = dictionary["Image"],
            let image = UIImage(named: imageName) else {
                return nil
        }
        self.init(image: image, title: title, date: date)
    }
    
    static func allAlbums() -> [Album] {
        var albums = [Album]()
        guard let URL = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
            let photosFromPlist = NSArray(contentsOf: URL) as? [[String:String]] else {
                return albums
        }
        for dictionary in photosFromPlist {
            if let album = Album(dictionary: dictionary) {
                albums.append(album)
            }
        }
        return albums
    }
}
