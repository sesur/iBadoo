//
//  CustomTabBarController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/19/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class CustomTabBarController: RAMAnimatedTabBarController {

    //MARK:- Navigation Controllers
    lazy var favoritesNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: FavoritesViewController())
        return navigationController
    }()
    lazy var inboxNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: BaseMessagesController())
//        let navigationController = UINavigationController(rootViewController: InboxViewController())
        return navigationController
    }()
    lazy var radarNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: RadarViewController())
        return navigationController
    }()
    lazy var alarmsNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: AlarmViewController())
        return navigationController
    }()
    lazy var pofileNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: MyProfileViewController())
        return navigationController
    }()

    
    
    //MARK:- TabBarItems
    private let favoritesTabBar: RAMAnimatedTabBarItem = {
        let favoritesItem = RAMAnimatedTabBarItem(title: TabBar.favorites.rawValue,
                                                image: UIImage(named: TabBar.Image.heart.rawValue),
                                                selectedImage: UIImage(named: TabBar.Image.heart.rawValue))
        favoritesItem.animation = RAMBounceAnimation()
        return favoritesItem
    }()
    private let alarmsTabBar: RAMAnimatedTabBarItem = {
        let alarmsItem = RAMAnimatedTabBarItem (title: TabBar.alarms.rawValue,
                                                image: UIImage(named: TabBar.Image.alarm.rawValue),
                                                selectedImage: UIImage(named: TabBar.Image.alarm.rawValue))
        alarmsItem.animation = RAMBounceAnimation()
        return alarmsItem
    }()
    private let radarTabBar: RAMAnimatedTabBarItem = {
        let radarItem = RAMAnimatedTabBarItem(title: "",
                                              image: UIImage(named: TabBar.Image.radar.rawValue),
                                              selectedImage: UIImage(named: TabBar.Image.radar.rawValue))
        radarItem.animation = RAMBounceAnimation()
        radarItem.yOffSet = 10
        return radarItem
    }()
    private let inboxTabBar: RAMAnimatedTabBarItem = {
        let inboxItem = RAMAnimatedTabBarItem(title: TabBar.inbox.rawValue,
                                                image: UIImage(named: TabBar.Image.inbox.rawValue),
                                                selectedImage: UIImage(named: TabBar.Image.inbox.rawValue))
        inboxItem.animation = RAMBounceAnimation()
        return inboxItem
    }()
    private let profileTabBar: RAMAnimatedTabBarItem = {
        let profileItem = RAMAnimatedTabBarItem(title: TabBar.profile.rawValue,
                                                 image: UIImage(named: TabBar.Image.profile.rawValue),
                                                 selectedImage: UIImage(named: TabBar.Image.profile.rawValue))
        profileItem.animation = RAMBounceAnimation()
        return profileItem
    }()

  
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarNavigationController()
        setupLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setSelectIndex(from: 0, to: 2)
    }
    
    private func setupTabBarNavigationController() {
        favoritesNavigationController.tabBarItem = favoritesTabBar
        inboxNavigationController.tabBarItem = inboxTabBar
        radarNavigationController.tabBarItem = radarTabBar
        alarmsNavigationController.tabBarItem = alarmsTabBar
        pofileNavigationController.tabBarItem = profileTabBar
        self.viewControllers = [favoritesNavigationController, inboxNavigationController, radarNavigationController, alarmsNavigationController, pofileNavigationController]
    }
    
    
    //MARK:- Layouts
    private func setupLayouts() {
        let button = UIButton()
        button.setImage(UIImage(named: "oval"), for: .normal)
        button.sizeToFit()

        tabBar.addSubview(button)
        button.anchorCenter(vertical: nil, horizontal: tabBar.centerXAnchor)
        button.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor, constant: -14).isActive = true

        tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        tabBar.layer.shadowRadius = 6
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
    }
}

