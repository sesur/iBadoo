//
//  MenuBarModel.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/14/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import Foundation

struct MenuBarModel {
    let nameLabel: MenuText
    let imageName: String
}

enum MenuText: String {
    case camera = "camera"
    case library = "library"
    
    case about = "ABOUT"
    case photos = "PHOTOS"
}
