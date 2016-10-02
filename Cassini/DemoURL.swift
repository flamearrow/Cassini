//
//  DemoURL.swift
//  Cassini
//
//  Created by Chen Cen on 10/2/16.
//  Copyright © 2016 Chen Cen. All rights reserved.
//

import Foundation

struct DemoURL {
    // need to define AppTransportSecuritySettings -> Allow arbitrary loads
    // to load non https images
    static let Bird = "http://hd.wallpaperswide.com/thumbs/angry_bird-t2.jpg"
    static let NASA = [
        "Cassini": "http://www.nasa.gov/sites/default/files/thumbnails/image/pia03883-nohuygens.jpg",
        "Earth": "https://static.pexels.com/photos/2422/sky-earth-galaxy-universe.jpg",
        "Sun": "https://pbs.twimg.com/profile_images/641353910561566720/VSxsyxs7.jpg"
    ]
    
    static func ImageNamed(imageName: String?) -> NSURL? {
        if let urlString = NASA[imageName ?? ""] {
            return NSURL(string: urlString)
        } else {
            return nil
        }
     }
}