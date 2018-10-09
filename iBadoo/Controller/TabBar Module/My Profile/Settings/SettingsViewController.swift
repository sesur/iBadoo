//
//  SettingsViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/16/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
class SettingsViewController: UIViewController {
    
    var settingsItem: MyProfileModel? {
        didSet {
            navigationItem.title = settingsItem?.nameLabel.rawValue
        }
    }
    private lazy var settingsView: SettingsView = {
        let view = SettingsView()
        view.delegate = self
        return view
    }()
    private lazy var facebookView: FacebookView = {
        let view = FacebookView()
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
        hideNavigationTabBar(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        hideNavigationTabBar(false)
    }
    
    private func setupNavigation() {
        if let topNavBar = self.navigationController?.navigationBar.topItem {
            topNavBar.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [settingsView, facebookView].forEach {view.addSubview($0)}
        settingsView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: 308))
        
        facebookView.anchor(top: settingsView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero)
    }
    
}

extension SettingsViewController: SettingsDelegate {
    func pushViewController(data: SettingsModel?, indexPath: IndexPath) {
        let settingsItem = settingsView.settingArray[indexPath.item]
        
        let generalVC = GeneralViewController()
        let phoneNrVC = PhoneNumberViewController()
        let aboutAppVC = AboutAppViewController()
        
        var vc = UIViewController()
        switch indexPath.item {
        case 0: vc = generalVC
                generalVC.generalItem = settingsItem
        case 1: vc = phoneNrVC
                phoneNrVC.phoneNrItem = settingsItem
        case 2: vc = aboutAppVC
                aboutAppVC.aboutAppItem = settingsItem
        default: break
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
