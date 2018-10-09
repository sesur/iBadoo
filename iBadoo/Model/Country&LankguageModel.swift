//
//  Country&LankguageModel.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation

struct CountryModel {
    let wasIn: Text
    let iconName: String
    let date: String
    let locationsVizited: String
    
    enum Text: String {
        case wasIn = "was in"
        case know = "know"
    }
    
    init(wasIn: Text, location: String, time: String) {
        self.wasIn = wasIn
        self.locationsVizited = location
        self.date = time
        self.iconName = "clock"
    }
}

struct LanguageModel{
    let know: Text
    let spokenLanguages: String
    
    enum Text: String {
        case wasIn = "was in"
        case know = "know"
    }
    
    init(know: Text, language: String) {
        self.know = know
        self.spokenLanguages = language
    }
    
}


