//
//  PostStruct.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-13.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import Foundation
import UIKit

struct Post {
    var feedsArray = [String]()
    var timeArray = [String]()
    var locationArray = [String]()
    var userNamesArray = [String]()
    var imagesArray = [String]()
    
    init(from dictionary: [String: Any]) {
        feedsArray = dictionary["fa"] as! [String]
        timeArray = dictionary["ta"] as! [String]
        locationArray = dictionary["la"] as! [String]
        userNamesArray = dictionary["una"] as! [String]
        imagesArray = dictionary["ia"] as! [String]
    }
    func onePost() -> [String: Any]{
        return ["fa": feedsArray, "ta":timeArray, "la":locationArray,"una":userNamesArray,"ia":imagesArray]
        
    }
}

