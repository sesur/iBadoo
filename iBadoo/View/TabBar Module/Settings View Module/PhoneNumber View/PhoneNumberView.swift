//
//  PhoneNumberView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class PhoneNumberView: BaseUIView {
    
    
    private lazy var phoneNrTextField: CustomTextField = {
        let text = CustomTextField()
        text.placeholder = Settings.Text.phoneNr.rawValue
        text.applyCustomClearButton(image: UIImage(named: "cancel")!)
        text.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        text.delegate = self
        text.keyboardType = .numberPad
        return text
    }()
    private lazy var codeFromSMSTextField: CustomTextField = {
        let text = CustomTextField()
        text.placeholder = Settings.Text.smsCode.rawValue
        text.applyCustomClearButton(image: UIImage(named: "cancel")!)
        text.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        text.delegate = self
        return text
    }()
    private let costsLabel: UILabel = {
        let label = UILabel()
        var customAttributtedString = NSMutableAttributedString()
        customAttributtedString = AttributedStringHelper.getString(text: Settings.Text.labelMessage.rawValue, fontType: .regular, size: 15, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
        customAttributtedString.addAttributes([.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 15)], range: NSRange(location: 57, length: 5))
        label.attributedText = customAttributtedString
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    private let changePhoneNrButton: CustomButton = {
        let button = CustomButton()
        let customAttributtedText = AttributedStringHelper.getString(text: Settings.Text.changePhoneNr.rawValue, fontType: .regular, size: 17, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        button.backgroundColor = .mainBlue
        button.setAttributedTitle(customAttributtedText, for: .normal)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        setupLayouts()
    }
    private func setupLayouts() {
        let separatorView = UIView()
        separatorView.backgroundColor = .separatorColor
        [phoneNrTextField, codeFromSMSTextField, separatorView, costsLabel, changePhoneNrButton].forEach {addSubview($0)}
        
        phoneNrTextField.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 95, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 54))
        
        separatorView.anchor(top: phoneNrTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        codeFromSMSTextField.anchor(top: separatorView.bottomAnchor, leading: phoneNrTextField.leadingAnchor , bottom: nil, trailing: phoneNrTextField.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 54))
        
        costsLabel.anchor(top: codeFromSMSTextField.bottomAnchor, leading: phoneNrTextField.leadingAnchor, bottom: nil, trailing: phoneNrTextField.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        changePhoneNrButton.anchor(top: costsLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 225, height: 48))
        changePhoneNrButton.anchorCenter(vertical: nil, horizontal: costsLabel.centerXAnchor)
        
    }
}

extension PhoneNumberView: UITextFieldDelegate  {
    
    //MARK:- TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
