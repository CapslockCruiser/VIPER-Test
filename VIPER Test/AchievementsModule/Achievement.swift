//
//  Achievement.swift
//  VIPER Test
//
//  Created by William Choi on 6/10/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

struct Achievement: Decodable {
    let id: Int
    let level: String
    let progress: Int
    let total: Int
    let bg_image_url: String
    let accessible: Bool
    var image: UIImage?
    
    mutating func setImage(image: UIImage) {
        self.image = image
    }
    
    private enum CodingKeys: String, CodingKey { case id, level, progress, total, bg_image_url, accessible }
}
