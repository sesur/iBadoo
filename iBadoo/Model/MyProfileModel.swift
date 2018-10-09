//
//  MyProfileModel.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/16/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation

struct MyProfileModel {
    let nameLabel: Text
    let imageName: String
}
enum Text: String {
    case aboutMe = "About me"
    case profilePictures = "Profile pictures"
    case settings = "Settings"
    case logOut = "Log out"
}


