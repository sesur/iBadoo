//
//  IndicatorView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/31/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class IndicatorView: UIView {
    var color = UIColor.clear {
        didSet { setNeedsDisplay() }
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        UIBezierPath(ovalIn: rect).fill()
    }
}

enum ActionDescriptor {
    case  write, addFriend, deleteFriend, block, unBlock
    
    func title(forDisplayMode displayMode: ButtonDisplayMode) -> String? {
        guard displayMode != .imageOnly else { return nil }
        
        switch self {
        case .write: return "Write"
        case .addFriend: return "Add friend"
        case .deleteFriend: return "Delete friend"
        case .block: return "Block"
        case .unBlock: return "Unlock"
        }
    }
    
    func image(forStyle style: ButtonStyle, displayMode: ButtonDisplayMode) -> UIImage? {
        guard displayMode != .titleOnly else { return nil }
        
        let name: String
        switch self {
        case .write: name = "write"
        case .addFriend: name = "add_friend"
        case .deleteFriend: name = "delete_friend"
        case .block: name =  "unlock"
        case .unBlock: name = "block"
            
        }
        
        return UIImage(named: style == .backgroundColor ? name : name + "-circle")
    }
    
    var color: UIColor {
        switch self {
        case .write: return .backGroundLightBlue
        case .addFriend: return .backGroundLightBlue
        case .block: return .backGroundLightBlue
        case .deleteFriend: return .backGroundLightBlue
        case .unBlock: return .backGroundLightBlue
        }
    }
}
