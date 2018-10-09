//
//  SetNewPasswordViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/11/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class SetNewPasswordViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "back")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var xCloseButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "close")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleCloseButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var saveButton: CustomButton = {
        let button = CustomButton()
        let customAttributtedText = AttributedStringHelper.getString(text: ButtonText.save.rawValue, fontType: .regular, size: 20, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        button.backgroundColor = .mainBlue
        button.setAttributedTitle(customAttributtedText, for: .normal)
        button.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var doNotHaveAnAccountButton: UIButton = {
        let button = UIButton()
        let customAttributtedText = AttributedStringHelper.getString(text: Login.doNothaveAnAccout.rawValue, fontType: .regular, size: 17, color: .mainBlue)
        button.setAttributedTitle(customAttributtedText, for: .normal)
        button.addTarget(self, action: #selector(handleDoNotHaveAccountButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var inputsTextFieldView: SetNewPasswordView = {
        let view = SetNewPasswordView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        dismissKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        UIApplication.shared.statusBarStyle = .default
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    private func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    //MARK:- Actions & Navigation
    @objc private func handleBackButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func handleDoNotHaveAccountButtonTap() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    @objc private func handleCloseButtonTap() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc private func handleSaveButtonTap() {
        navigationController?.pushViewController(UploadProfileViewController(), animated: true)
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [backButton, xCloseButton, inputsTextFieldView, doNotHaveAnAccountButton, saveButton].forEach {view.addSubview($0)}
        
        xCloseButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 20), size: .init(width: 36, height: 36))
        
        backButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 20, bottom: 0, right: 0), size: .init(width: 36, height: 36))
        
        inputsTextFieldView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 166, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 221))
        
        [doNotHaveAnAccountButton, saveButton].forEach {
            $0.anchorCenter(vertical: nil, horizontal: view.centerXAnchor)}
        doNotHaveAnAccountButton.anchor(top: nil, leading: saveButton.leadingAnchor, bottom: saveButton.topAnchor, trailing: saveButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 30, right: 0), size: .init(width: 0, height: 25))
        
        saveButton.anchor(top: nil, leading: nil, bottom:  view.bottomAnchor, trailing: nil , padding: .init(top: 0, left: 0, bottom: 50, right: 0), size: .init(width: 235, height: 50))
    }
}
