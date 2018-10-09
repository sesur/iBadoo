//
//  PrivacyPolicyViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
   
    var policyPrivacyItem: SettingsModel? {
        didSet {
            navigationItem.title = policyPrivacyItem?.nameLabel.rawValue
        } 
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Privacy Policy"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
//        if let topNav = self.navigationController?.navigationBar.topItem {
//            topNav.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        }
        
//        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//        navigationController?.navigationBar.titleTextAttributes = attributes
//        navigationController?.navigationBar.barTintColor = .mainBlue
    }
}
