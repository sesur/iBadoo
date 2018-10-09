//
//  GeneralViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

//import IQKeyboardManagerSwift

class GeneralViewController: UIViewController {
    
    private var bottomConstraint: NSLayoutConstraint?
    var generalItem: SettingsModel? {
        didSet {
            navigationItem.title = generalItem?.nameLabel.rawValue
        }
    }
    
    private let scroll: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    private let container: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var userFormView: UserFormView = {
        let view = UserFormView()
        return view
    }()
    private lazy var maleFemaleRadioButtonsView: RadioButtonsView = {
        let view = RadioButtonsView()
        return view
    }()
    private lazy var passwordFormView: PasswordFormView = {
        let view = PasswordFormView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupLayouts()
        dismissKeyboard()
        setupKeyboardNotifications()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.sharedManager().enable = true
        if let tabBar = self.tabBarController as? CustomTabBarController {
            tabBar.animationTabBarHidden(true)
        }
    }
    private func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    private func setupNavigation() {
        if let topNav = self.navigationController?.navigationBar.topItem {
            topNav.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
    }

    
    //MARK:- Keyboard Notifications
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardTap), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardTap), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleKeyboardTap(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboardFrameSize = ((userInfo[UIResponder.keyboardFrameBeginUserInfoKey]) as AnyObject).cgRectValue else {return}
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrameSize.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.scroll.layoutIfNeeded()
            }, completion: { (completed) in
//                self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                
            })
        }
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        view.addSubview(scroll)
        scroll.fillSuperView()
        
        scroll.addSubview(container)
        container.fillSuperView()
        container.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true // the most important
        
        [userFormView, maleFemaleRadioButtonsView, passwordFormView].forEach {scroll.addSubview($0)}
        userFormView.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: nil, trailing: container.trailingAnchor, padding: .zero, size: .init(width: 0, height: 250))
        
        maleFemaleRadioButtonsView.anchor(top: userFormView.bottomAnchor, leading: container.leadingAnchor, bottom: nil, trailing: container.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 90))
        
        passwordFormView.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: .init(top: 350, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 290))
        
    }
}
