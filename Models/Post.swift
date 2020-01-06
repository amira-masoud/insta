//
//  Post.swift
//  Insta
//
//  Created by Amira on 1/1/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import Foundation
class Post  {
    var caption : String
    var photoUrl : String
    
    init(captionText : String, photoUrlString: String) {
        caption = captionText
        photoUrl = photoUrlString
    }
}
