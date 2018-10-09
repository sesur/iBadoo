//
//  SettingsModel.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/21/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation

struct SettingsModel {
    let nameLabel: Text
    let imageName: String
    let subtitle: Text?
   
    enum Text: String {
        case general = "General"
        case phoneNumber = "Phone number"
        case aboutApp = "About application"
        case logOut = "Log out"
        case followUs = "Follow us on facebook!"
        case like = "Like"
        case k = "11k of people like it."
        case changePhoneNr = "You can change your phone number"
        case empty = ""
        
        case termsAndConditions = "Terms and Conditions"
        case privacyAndPolicy = "Privacy Policy"
        case appVersion = "Application version"
        case appExactVersion = "v1.0.0"
    }
}

