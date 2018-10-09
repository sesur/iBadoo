//
//  ProfileGrapthRequest.swift
//  iBadoo
//
//  Created by Sergiu on 9/14/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation
import FacebookCore
import SwiftyJSON

struct ProfileGraphRequest: GraphRequestProtocol {
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name, first_name, last_name, email, picture.type(large)"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
    
    struct Response: GraphResponseProtocol {
        var _id: String?
        var _fullName: String? = "NA"
        var _firstName: String? = "NA"
        var _lastName: String? = "NA"
        var _gender: String? = "NA"
        var _email: String? = "NA"
        var _profilePictureUrl: String? = "https://www.mautic.org/media/images/default_avatar.png"
        
        init(rawResponse: Any?) {
            guard let response = rawResponse else {return}
            let jsonResponse = JSON(response)
            guard let id = jsonResponse["id"].string else {return}
            _id = id
            guard let fullName = jsonResponse["name"].string else {return}
            _fullName = fullName
            guard let firstName = jsonResponse["first_name"].string else {return}
            _firstName = firstName
            guard let lastName = jsonResponse["last_name"].string else {return}
            _lastName = lastName
            guard let email = jsonResponse["email"].string else {return}
            _email = email
            
            guard let pictureUrl = jsonResponse["picture"]["data"]["url"].string else {return}
            _profilePictureUrl = pictureUrl
            
        }
    }
    
    
}

