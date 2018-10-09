//
//  AppVersionViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class AppVersionViewController: UIViewController {
    
    var appVersionItem: SettingsModel? {
        didSet {
            navigationItem.title = appVersionItem?.nameLabel.rawValue
        }
    }
    
    private let appVersionView:  AppVersionView = {
        let view = AppVersionView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let tabBar = self.tabBarController as? CustomTabBarController {
            tabBar.animationTabBarHidden(true)
        }
    }
    
    //MARK:- Layouts
    private func setupNavigation() {
        if let topNav = self.navigationController?.navigationBar.topItem {
            topNav.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
    }
    private func setupLayouts() {
        view.addSubview(appVersionView)
        appVersionView.fillSuperView()
    }
}
