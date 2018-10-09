//
//  CustomDesign.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/6/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//


import UIKit

protocol RoundCornerProtocol { }
protocol DropDownShadowProtocol { }
protocol BorderProtocol  { }
protocol FontProtocol { }



final class CustomImage: UIImageView { }


final class CustomTextView: UITextView {
 
}

final class CustomUIView: UIView, DropDownShadowProtocol {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addShadow()
    }
}

final class CustomButton: UIButton, BorderProtocol, RoundCornerProtocol{
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addBorder(color: .mainBlue)
        addBorder(width: 1.0)
        addRoundCorner()
        translatesAutoresizingMaskIntoConstraints = false
    }
}

final class CustomTextField: UITextField, BorderProtocol, RoundCornerProtocol, UITextFieldDelegate {
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect)
        addRoundCorner()
        addBorder(width: 1.0)
//        spellCheckingType = .no
        autocorrectionType = .no
        autocapitalizationType = .none
    }
    
    //MARK:- TextFieldDelegate
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    func setPlaceHolderColor(color: UIColor){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.clearsOnBeginEditing = true
//        textField.resignFirstResponder()
//        return true
//    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        textField.text = ""
        return true
    }


}




