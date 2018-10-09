//
//  TermsConditionsViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class TermsConditionsViewController: UIViewController {
    
    var termsConditionsItem: SettingsModel? {
        didSet {
            navigationItem.title = termsConditionsItem?.nameLabel.rawValue
        }
    }
//    
    private let termsAndConditionsView: TermsAndConditionsView = {
        let view = TermsAndConditionsView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigation()
//        UIApplication.shared.statusBarStyle = .lightContent
        if let tabBar = self.tabBarController as? CustomTabBarController {
            tabBar.animationTabBarHidden(true)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationItem.title = " "
    }
    private func setupNavigation() {
        navigationItem.title = "Terms and Conditions"
        navigationController?.setNavigationBarHidden(false, animated: true)

//        if let topNav = self.navigationController?.navigationBar.topItem {
//            topNav.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        }

    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        view.addSubview(termsAndConditionsView)
        termsAndConditionsView.fillSuperView()
    }
}
