//
//  ProfileViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    private lazy var profileView: MyProfileView = {
        let view = MyProfileView()
        view.delegate = self
        return view
    }()

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    //MARK:- Layouts
    private func setupLayouts(){
        view.addSubview(profileView)
        profileView.fillSuperView()
    }
    private func setupNavigationBar(){
        navigationItem.title = " My profile"
        navigationController?.navigationBar.barTintColor = .mainBlue
        navigationController?.navigationBar.tintColor = .white
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}

extension MyProfileViewController: MyProfileDelegate {
    func pushViewController(data: MyProfileModel?, indexPath: IndexPath) {
        let profileItem = profileView.settingArray[indexPath.item]
        
        var viewController = UIViewController()
        switch indexPath.item {
        case 0: viewController = AboutMeViewController()
                AboutMeViewController().myProfileItem = profileItem
        case 1: viewController = ProfilePictureViewController()
                ProfilePictureViewController().profilePictureItem = profileItem
        case 2: viewController = SettingsViewController()
                SettingsViewController().settingsItem = profileItem
        
        default: viewController = SwipeViewController(collectionViewLayout: UICollectionViewFlowLayout()) //ProfileVC()
        }
        
        if viewController.isKind(of: SwipeViewController.self) {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let swipeViewController = SwipeViewController(collectionViewLayout: layout)
            navigationController?.initRootViewController(viewController: swipeViewController, transitionType: "fromRight", duration: 0.4)
        } else {
          navigationController?.pushViewController(viewController, animated: true)
        }
        
        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.animationTabBarHidden(true)
        }
    }
}



