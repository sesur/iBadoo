//
//  RegisterViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/1/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private lazy var xCloseButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "close")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleCloseButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var registerInputsTextFieldView: RegisterInputsTextFieldView = {
        let view = RegisterInputsTextFieldView()
        return view
    }()
    
    private lazy var registerAccountButton: CustomButton = {
        let button = CustomButton()
        let customAttributtedText = AttributedStringHelper.getString(text: ButtonText.registerAnAcoount.rawValue, fontType: .regular, size: 20, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        button.backgroundColor = .mainBlue
        button.setAttributedTitle(customAttributtedText, for: .normal)
        button.addTarget(self, action: #selector(handleRegisterButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var youHaveAnAccountButton: UIButton = {
        let question = UIButton()
        let customAttributtedText = AttributedStringHelper.getString(text: Register.youHaveAccount.rawValue, fontType: .regular, size: 17, color: .mainBlue)
        question.setAttributedTitle(customAttributtedText, for: .normal)
        question.translatesAutoresizingMaskIntoConstraints = false
        question.addTarget(self, action: #selector(handleRegisterButtonTap), for: .touchUpInside)
        return question
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        dismissKeyboard()
        setupApplicationNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.preferredStatusBarStyle = 
//        UIApplication.shared.statusBarStyle = .default
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    private func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    //MARK:- Actions & Navigation
    private func setupApplicationNavigation() {
        registerInputsTextFieldView.termsAndConditionsAction = navigateToTermsAndConditionsViewController
        registerInputsTextFieldView.privacyPolicyAction = navigateToPrivacyPolicyController
    }
    private func navigateToTermsAndConditionsViewController() {
        navigationController?.pushViewController(TermsConditionsViewController(), animated: true)
    }
    private func navigateToPrivacyPolicyController() {
         navigationController?.pushViewController(PrivacyPolicyViewController(), animated: true)
    }
    
    @objc private func handleCloseButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func handleRegisterButtonTap() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [xCloseButton, registerInputsTextFieldView, youHaveAnAccountButton, registerAccountButton].forEach {view.addSubview($0)}
        
        xCloseButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20), size: .init(width: 36, height: 36))
        
        registerInputsTextFieldView.anchor(top: xCloseButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))

       [youHaveAnAccountButton, registerAccountButton].forEach {
        $0.anchorCenter(vertical: nil, horizontal: view.centerXAnchor)}
        
        youHaveAnAccountButton.anchor(top: nil, leading: registerAccountButton.leadingAnchor, bottom: registerAccountButton.topAnchor, trailing: registerAccountButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 30, right: 0), size: .init(width: 0, height: 25))
        
        registerAccountButton.anchor(top: nil, leading: nil, bottom:  view.bottomAnchor, trailing: nil , padding: .init(top: 0, left: 0, bottom: 50, right: 0), size: .init(width: 235, height: 50))
    }
    
}

