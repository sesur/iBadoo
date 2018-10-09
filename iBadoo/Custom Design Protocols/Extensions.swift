//
//  Extentions.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/6/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

extension DropDownShadowProtocol where Self: UIView {
    func addShadow() {
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 1.0).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 6.0
        layer.shadowOffset = CGSize(width: 1.0, height: 5)
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
    }
}

extension BorderProtocol where Self: UIView {
    func addBorder(color withColor: UIColor) {
        layer.borderColor = withColor.cgColor
    }
    func addBorder(width withWidth: CGFloat) {
        layer.borderWidth = withWidth
    }
}

extension RoundCornerProtocol where Self: UIView {
    func addRoundCorner() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}

extension UIColor {
    static var mainBlue = #colorLiteral(red: 0, green: 0.2860870957, blue: 0.9036547542, alpha: 1)
    static var backGroundLightBlue = #colorLiteral(red: 0.9440002441, green: 0.9570352435, blue: 0.9892687201, alpha: 1)
    
    static var middleCircleBlue = #colorLiteral(red: 0.5859932899, green: 0.6848644018, blue: 1, alpha: 1)
    static var biggerCircleBlue = #colorLiteral(red: 0.7903425097, green: 0.8402482867, blue: 1, alpha: 1)
    static var separatorColor = #colorLiteral(red: 0.7781105638, green: 0.8196478486, blue: 0.8763825297, alpha: 1)
    
    static var backGroundColor = #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
}

extension UITextField {
    func applyCustomClearButton(image: UIImage) {
//        clearButtonMode = .whileEditing
        rightViewMode = .whileEditing
        let clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        clearButton.setImage(image, for: .normal)
        clearButton.addTarget(self, action: #selector(clearClicked), for: .touchUpInside)
        rightView = clearButton
    }
    func applyDropDownButton(image: UIImage) {
        rightViewMode = .always
        let dropDownButton = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        dropDownButton.setImage(image, for: .normal)
        rightView = dropDownButton
    }
    
    
    
    @objc func clearClicked(sender: UIButton) {
        text = nil
    }
}

//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }









