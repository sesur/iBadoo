//
//  AttributedStringHelper.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/6/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

struct AttributedStringHelper {
    
    enum FontType: String {
        case regular = "SanFranciscoDisplay-Regular"
    }
    
    static func getString(text: String, fontType: FontType, size: CGFloat, color: UIColor? , isUnderlined: Bool? = nil) -> NSMutableAttributedString {
        
        var attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont(name: fontType.rawValue, size: size)!,
            NSAttributedString.Key.foregroundColor : color as Any]
        
        if let isUnderlined = isUnderlined, isUnderlined {
            attributes[NSAttributedString.Key.underlineStyle] = 1
        }
        
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        return attributedString
    }
    
    
    static func getStringNoneColor(text: String, fontType: FontType, size: CGFloat, isUnderlined: Bool? = nil) -> NSMutableAttributedString {
        
        var attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont(name: fontType.rawValue, size: size)!]
        
        if let isUnderlined = isUnderlined, isUnderlined {
            attributes[NSAttributedString.Key.underlineStyle] = 1
        }
        
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        return attributedString
    }
}


