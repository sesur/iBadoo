//
//  CurrentUser.swift
//  iBadoo
//
//  Created by Sergiu on 8/6/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation

class CurrentUser {
    
    var id: String?
    let fullName: String?
//    let firstName: String?
//    let lastName: String?
//    let email: String?
    let profilePictureUrl: String
    
    var addFriend: Bool
    var blockFriend: Bool
    
    init (id: String? = nil, dictionaryValues: [String: Any]) {
        self.id = id
        self.fullName = dictionaryValues["fullName"] as? String ?? ""
        self.profilePictureUrl = dictionaryValues["imageUrl"] as? String ?? ""
        self.addFriend = false
        self.blockFriend = true
    }

}
