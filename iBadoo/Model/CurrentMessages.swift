//
//  CurentMessages.swift
//  iBadoo
//
//  Created by Sergiu on 8/29/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation
import Firebase


class CurrentMessages {
    var message: String?
    var fromId : String?
    var toId: String?
    var timestamp: Int?
    
    var key: String?
    
    
    init (dictionaryValues: [String: Any]) {
        self.message = dictionaryValues["message"] as? String ?? ""
        self.fromId = dictionaryValues["fromId"] as? String
        self.toId = dictionaryValues["toId"] as? String ?? ""
        self.timestamp =  dictionaryValues["timestamp"] as? Int
    }
    init (key: [String: Any]) {
        self.fromId = key["fromId"] as? String ?? ""
        self.toId = key["toId"] as? String ?? ""
    }
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
}
