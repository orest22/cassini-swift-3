//
//  DemoUrl.swift
//  Cassini-New
//
//  Created by Orest Hazda on 29/10/16.
//  Copyright © 2016 Orest Hazda. All rights reserved.
//

import Foundation

struct DemoURL {
    static let Stanford = "http://images.freeimages.com/images/previews/37b/stanford-columns-4-1500285.jpg"
    
    static let NASA = [
        "Cassini" : "http://www.sun.org/uploads/images/mainimage_Saturn-cassini-March-27-2004.jpg",
        "Earth" : "http://images.freeimages.com/images/previews/328/earth-1191968.jpg",
        "Saturn" : "http://images.freeimages.com/images/previews/158/moon-3-1056241.jpg",
        
    ]
    
    static func NASAImageNamed(imageName: String?) -> NSURL? {
        if let urlstring = NASA[imageName ?? "" ] {
            return NSURL(string: urlstring)
        } else {
            return nil
        }
    }
    
}
