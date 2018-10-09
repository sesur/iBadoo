//
//  RegisterInputsTextFieldView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 3/1/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class RegisterInputsTextFieldView: BaseUIView, UITextFieldDelegate, UITextViewDelegate {
    
    var termsAndConditionsRange = NSRange(location: 53, length: 19)
    var privacyPolicyRange = NSRange(location: 76, length: 14)
    
    var termsAndConditionsAction: (()->())?
    var privacyPolicyAction: (()->())?
    
    private let topMessageLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: Register.header.rawValue, fontType: .regular, size: 28, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let phoneTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Register.phoneNumber.rawValue
        textField.keyboardType = .numberPad
        textField.applyCustomClearButton(image: UIImage(named: "cancel")!)
        textField.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Register.password.rawValue
        textField.isSecureTextEntry = true
        textField.applyCustomClearButton(image: UIImage(named: "cancel")!)
        textField.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        return textField
    }()
    
    private let retypePassTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Register.retypePassword.rawValue
        textField.isSecureTextEntry = true
        textField.applyCustomClearButton(image: UIImage(named: "cancel")!)
        textField.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        return textField
    }()
    
    private lazy var termsAndConditionsLabel: UITextView = {
        let label = UITextView()
        var allText = Register.termsAndConditions.rawValue
        var customAttributtedString = NSMutableAttributedString()
        customAttributtedString = AttributedStringHelper.getString(text: allText, fontType: .regular, size: 13, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        customAttributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainBlue, range: termsAndConditionsRange)
        
        // added
        customAttributtedString.addAttribute(.link, value: "terms", range: termsAndConditionsRange)
        customAttributtedString.addAttribute(.link, value: "policy", range: privacyPolicyRange)
       //
        customAttributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainBlue, range: privacyPolicyRange)
        
        label.attributedText = customAttributtedString
        label.textAlignment = .center
        label.isSelectable = true
        label.isUserInteractionEnabled = true
        label.isEditable = false
        label.delegate = self
        label.isScrollEnabled = false
//        label.sizeThatFits(CGSize(width: self.frame.size.width, height: self.frame.size.height))
        return label
    }()
    
//    private let termsAndConditionsLabel: UILabel = {
//        let label = UILabel()
//        var customAttributtedString = NSMutableAttributedString()
//        customAttributtedString = AttributedStringHelper.getString(text: Register.termsAndConditions.rawValue, fontType: .regular, size: 13, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
//        customAttributtedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.mainBlue, range: NSRange(location: 53, length: 19))
//        customAttributtedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.mainBlue, range: NSRange(location: 76, length: 14))
//
//        label.attributedText = customAttributtedString
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        return label
//    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
        dismissKeyboard()
    }
    
    
    //MARK:- Layouts
    private func setupLayouts() {
        let textFieldStack = UIStackView(arrangedSubviews: [topMessageLabel, phoneTextField, passwordTextField, retypePassTextField])
        textFieldStack.distribution = .fillEqually
        textFieldStack.axis = .vertical
        textFieldStack.spacing = 20
        
        [textFieldStack, termsAndConditionsLabel].forEach {addSubview($0)}
        
        textFieldStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: termsAndConditionsLabel.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 35, bottom: 2 , right: 35), size: .zero)
        
        [phoneTextField, passwordTextField, retypePassTextField].forEach({$0.heightAnchor.constraint(equalToConstant: 44).isActive = true})
        
        termsAndConditionsLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 35 , bottom: 2, right: 35), size: .init(width: 0, height: 65 ))
    }
    
    //MARK:- UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if characterRange == termsAndConditionsRange {
            termsAndConditionsAction?()
        } else {
            privacyPolicyAction?()
        }
        return true
    }
    
    //MARK:-
    private func dismissKeyboard() {
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        retypePassTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneTextField.endEditing(true)
        passwordTextField.endEditing(true)
        retypePassTextField.endEditing(true)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if phoneTextField.isFirstResponder, passwordTextField.isFirstResponder, retypePassTextField.isFirstResponder {
            phoneTextField.placeholder = ""
            passwordTextField.placeholder = ""
            retypePassTextField.placeholder = ""
        }
    }
    
}
