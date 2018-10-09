//
//  AboutAppViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {
    
    var aboutAppItem: SettingsModel? {
        didSet {
            navigationItem.title = aboutAppItem?.nameLabel.rawValue
        }
    }
    private lazy var aboutAppView: AboutAppView = {
        let view = AboutAppView()
        view.delegate = self
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
        view.addSubview(aboutAppView)
        aboutAppView.fillSuperView()
    }
}


extension AboutAppViewController: AboutAppDelegate {
    func pushViewController(data: SettingsModel?, indexPath: IndexPath) {
            let aboutAppItem = aboutAppView.aboutAppArray[indexPath.item]
            
            let termsConditionsVC = TermsConditionsViewController()
            let appVersionVC = AppVersionViewController()
            let privacyPolicy = PrivacyPolicyViewController()
            
            var vc = UIViewController()
            switch indexPath.item {
            case 0: vc = termsConditionsVC
                    termsConditionsVC.termsConditionsItem = aboutAppItem
            case 1: vc = privacyPolicy
                    privacyPolicy.policyPrivacyItem = aboutAppItem
            case 2:vc = appVersionVC
                    appVersionVC.appVersionItem = aboutAppItem
                
            default: break
            }
        navigationController?.pushViewController(vc, animated: true)
    }
}
