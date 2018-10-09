//
//  PasswordFormView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class PasswordFormView: BaseUIView {
    
 
    private let changePasswordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: Settings.Text.changePassword.rawValue, fontType: .regular, size: 17, color: .black)
        label.sizeToFit()
        return label
    }()
    private lazy var oldPasswordTextField: CustomTextField = {
        let pass = CustomTextField()
        pass.placeholder = Settings.Text.oldPasswordPlaceholder.rawValue
        pass.isSecureTextEntry = true
        pass.applyCustomClearButton(image: UIImage(named: "cancel")!)
        pass.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        pass.delegate = self
        return pass
    }()
    
    private lazy var newPasswordTextField: CustomTextField = {
        let pass = CustomTextField()
        pass.placeholder = Settings.Text.newPasswordPlaceholder.rawValue
        pass.isSecureTextEntry = true
        pass.applyCustomClearButton(image: UIImage(named: "cancel")!)
        pass.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        pass.delegate = self
        return pass
    }()
    
    
    private lazy var confirmNewPasswordTextField: CustomTextField = {
        let pass = CustomTextField()
        pass.placeholder = Settings.Text.confirmPasswordPlaceholder.rawValue
        pass.isSecureTextEntry = true
        pass.applyCustomClearButton(image: UIImage(named: "cancel")!)
        pass.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        pass.delegate = self
        return pass
    }()
    
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    
    private func setupLayouts() {
        let stack = UIStackView(arrangedSubviews: [oldPasswordTextField, newPasswordTextField, confirmNewPasswordTextField])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 25
        stack.alignment = .fill
        
        [changePasswordLabel, stack].forEach {addSubview($0)}
        
         changePasswordLabel.anchor(top: topAnchor, leading: stack.leadingAnchor, bottom: nil, trailing: stack.trailingAnchor, padding: .zero, size: .init(width: 0, height: 30))
        
        stack.anchor(top: changePasswordLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 30, left: 32, bottom: 8, right: 32), size: .zero)
    }
}

extension PasswordFormView: UITextFieldDelegate  {
    
    //MARK:- TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
