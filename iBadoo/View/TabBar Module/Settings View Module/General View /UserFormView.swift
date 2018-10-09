//
//  UserFormView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserFormView: BaseUIView {
    
   lazy var firstNameTextField: CustomTextField = {
        let firstName = CustomTextField()
        firstName.placeholder = ProfileInfo.firstName.rawValue
        firstName.applyCustomClearButton(image: UIImage(named: "cancel")!)
        firstName.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        firstName.delegate = self
        return firstName
    }()
   lazy var lastNameTextField: CustomTextField = {
        let lastName = CustomTextField()
        lastName.placeholder = ProfileInfo.lastName.rawValue
        lastName.applyCustomClearButton(image: UIImage(named: "cancel")!)
        lastName.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        lastName.delegate = self
        return lastName
    }()
   lazy var birthDateTextField: CustomTextField = {
        let birthDate = CustomTextField()
        birthDate.placeholder = ProfileInfo.birthDate.rawValue
        birthDate.applyCustomClearButton(image: UIImage(named: "cancel")!)
        birthDate.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        birthDate.delegate = self
        return birthDate
    }()
    
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    private func setupLayouts() {
        let stack = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, birthDateTextField])
        addSubview(stack)
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 25

        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 30, left: 32, bottom: 0, right: 32), size: .zero)
    }
}
extension UserFormView: UITextFieldDelegate  {
    
    //MARK:- TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
