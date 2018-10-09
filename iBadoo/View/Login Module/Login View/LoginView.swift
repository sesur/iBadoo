//
//  LoginView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 3/2/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class LoginView: BaseUIView, UITextFieldDelegate {
    
    var loginController: LoginViewController? {
        didSet {
            
        }
    }
    
    //MARK:- Facebook login button
    private lazy var facebookLoginButton: CustomButton = {
        let button = CustomButton(type: .system)
        let customAttributtedText = AttributedStringHelper.getString(text: ButtonText.loginWithFacebook.rawValue, fontType: .regular, size: 20, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        button.backgroundColor = .mainBlue
        button.setAttributedTitle(customAttributtedText, for: .normal)
        button.setImage(UIImage(named: "f")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: (button.frame.width - 35) , bottom: 5, right: 5)
        button.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.addTarget(loginController, action: #selector(LoginViewController.handleFacebookLoginTap), for: .touchUpInside)
        //        button.delegate = self
        return button
    }()
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "back")
        button.setImage(image, for: .normal)
        button.addTarget(loginController, action: #selector(LoginViewController.handleBackButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var xCloseButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "close")
        button.setImage(image, for: .normal)
        button.addTarget(loginController, action: #selector(LoginViewController.handleCloseButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var loginButton: CustomButton = {
        let button = CustomButton()
        let customAttributtedText = AttributedStringHelper.getString(text: ButtonText.login.rawValue, fontType: .regular, size: 20, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        button.backgroundColor = .mainBlue
        button.setAttributedTitle(customAttributtedText, for: .normal)
        button.addTarget(loginController, action: #selector(LoginViewController.handleLoginTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var doNotHaveAnAccountButton: UIButton = {
        let question = UIButton()
        let customAttributtedText = AttributedStringHelper.getString(text: Login.doNothaveAnAccout.rawValue, fontType: .regular, size: 17, color: .mainBlue)
        question.setAttributedTitle(customAttributtedText, for: .normal)
        question.addTarget(loginController, action: #selector(LoginViewController.handleDoNotHaveButtonTap), for: .touchUpInside)
        return question
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let question = UIButton()
        let customAttributtedText = AttributedStringHelper.getString(text: Login.forgotPassword.rawValue, fontType: .regular, size: 17, color: .mainBlue)
        question.setAttributedTitle(customAttributtedText, for: .normal)
        question.addTarget(loginController, action: #selector(LoginViewController.handleForgotButtonTap), for: .touchUpInside)
        return question
    }()
    
    private let topMessageLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: Login.header.rawValue, fontType: .regular, size: 28, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    let phoneTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Register.phoneNumber.rawValue
        textField.setPlaceHolderColor(color: .red)
        textField.keyboardType = .numberPad
        textField.applyCustomClearButton(image: UIImage(named: "alert icon")!)
        textField.addBorder(color: .red)
        return textField
    }()
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Register.password.rawValue
        textField.setPlaceHolderColor(color: .red)
        textField.isSecureTextEntry = true
        textField.applyCustomClearButton(image: UIImage(named: "alert icon")!)
        textField.addBorder(color: .red)
        return textField
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
        dismissKeyboard()
    }
    
    private func setupLayouts() {
        let textFieldStack = UIStackView(arrangedSubviews: [topMessageLabel, phoneTextField, passwordTextField])
        textFieldStack.distribution = .fillEqually
        textFieldStack.axis = .vertical
        textFieldStack.spacing = 20
//        [textFieldStack].forEach {addSubview($0)}
        
        
       
        
//        textFieldStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 35, bottom: 0, right: 35), size: .zero)
        
        [phoneTextField, passwordTextField].forEach({$0.heightAnchor.constraint(equalToConstant: 44).isActive = true})
        
        
        
        let bottomStack = UIStackView(arrangedSubviews: [forgotPasswordButton, doNotHaveAnAccountButton])
        bottomStack.axis = .vertical
        bottomStack.distribution = .fillEqually
        bottomStack.spacing = 10
        
        [backButton, xCloseButton, bottomStack , loginButton, textFieldStack, facebookLoginButton].forEach { addSubview($0) }
        
        xCloseButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20), size: .init(width: 36, height: 36))
        
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0), size: .init(width: 36, height: 36))
        
         textFieldStack.anchor(top: backButton.bottomAnchor, leading: backButton.leadingAnchor, bottom: nil, trailing: xCloseButton.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        facebookLoginButton.anchor(top: textFieldStack.bottomAnchor, leading: textFieldStack.leadingAnchor , bottom: nil, trailing: textFieldStack.trailingAnchor, padding: .zero, size: .init(width: 0, height: 44))
        
        
        bottomStack.anchor(top: nil, leading: loginButton.leadingAnchor, bottom: loginButton.topAnchor, trailing: loginButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0), size: .zero)
        
        [bottomStack, loginButton].forEach {
            $0.anchorCenter(vertical: nil, horizontal: centerXAnchor)}
        
        
        loginButton.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil , padding: .init(top: 0, left: 0, bottom: 50, right: 0), size: .init(width: 235, height: 50))
    }
    
    
    
    
    
    //MARK:- TextFieldDelegate
    private func dismissKeyboard() {
        phoneTextField.delegate = self
        passwordTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if phoneTextField.isFirstResponder, passwordTextField.isFirstResponder {
            phoneTextField.placeholder = ""
            passwordTextField.placeholder = ""
        }
    }
}
