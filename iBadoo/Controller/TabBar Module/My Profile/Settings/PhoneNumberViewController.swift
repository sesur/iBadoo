//
//  PhoneNumberViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    
    var phoneNrItem: SettingsModel? {
        didSet {
            navigationItem.title = phoneNrItem?.nameLabel.rawValue
        }
    }
    private let phoneNrView: PhoneNumberView = {
        let view = PhoneNumberView()
        return view
    }()

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLayouts()
        dismissKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let tabBar = self.tabBarController as? CustomTabBarController {
            tabBar.animationTabBarHidden(true)
        }
    }
    private func setupNavigation() {
        if let topNav = self.navigationController?.navigationBar.topItem {
            topNav.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
    }
    
    private func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    //MARK:- Layouts
    
    private func setupLayouts() {
        view.addSubview(phoneNrView)
        phoneNrView.fillSuperView()
    }
}
