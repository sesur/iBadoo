//
//  ConfirmSmsView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 3/2/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class ConfirmSmsView: BaseUIView, UITextFieldDelegate {
    
    private let topMessageLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: Confirm.header.rawValue, fontType: .regular, size: 28, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    private let confirmSmsTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Confirm.codeFromSms.rawValue
        textField.applyCustomClearButton(image: UIImage(named: "cancel")!)
        textField.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        return textField
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
        dismissKeyboard()
    }
    
    private func setupLayouts() {
        let textFieldStack = UIStackView(arrangedSubviews: [confirmSmsTextField])
        textFieldStack.distribution = .fillEqually
        textFieldStack.axis = .vertical
        textFieldStack.spacing = 25
        
        [topMessageLabel, textFieldStack].forEach {addSubview($0)}
        topMessageLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 35, bottom: 0, right: 35), size: .init(width: 0, height: 38))
        
        textFieldStack.anchor(top: topMessageLabel.bottomAnchor, leading: topMessageLabel.leadingAnchor, bottom: bottomAnchor, trailing: topMessageLabel.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .zero)
    }
    
    //MARK:- TextFieldDelegate
    private func dismissKeyboard() {
        confirmSmsTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        confirmSmsTextField.endEditing(true)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if confirmSmsTextField.isFirstResponder {
//            confirmSmsTextField.placeholder = ""
        }
    }
}
