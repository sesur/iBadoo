//
//  RadarViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class RadarViewController: UIViewController  {
    
    var allUsers = [CurrentUser]()
    
//    private lazy var nearByPeopleView: NearByPeopleView = {
//        let view = NearByPeopleView()
//        return view
//    }()
    
    private lazy var defaultRadarView: DefaultRadarView = {
        let view = DefaultRadarView()
        return view
    }()
    
    private var embedController: EmbedController?
    lazy var newViewController : NearbyPeopleViewController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let viewController = NearbyPeopleViewController(collectionViewLayout: layout)
        viewController.nearbayPeopleArray = allUsers
        return viewController
    }()
    
    
    //MARK:- Fetch Data
    private func fetchData() {
        DataModelService.sharedInstance.fetchUserFromFirebase { (user) in
            self.defaultRadarView.userObserver = user
        }
        
        DataModelService.sharedInstance.fetchAllUsersFromFirebase { (allUsers) in
            self.allUsers.append(allUsers)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.getUserData), name: NSNotification.Name(rawValue: dataModelDidUpdateNotification), object: nil)
        }
    }
    @objc private func getUserData() {
//        if let data = DataModelService.sharedInstance.data {
////            nearByPeopleView.usersObserver = data
//        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: dataModelDidUpdateNotification), object: self)
    }
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        setupNavigationBar()
        setupLayouts()
    }
    
    
    private func addChildViewControllers() {
        
        embedController = EmbedController(rootViewController: self)
        newViewController.view.fillSuperView()
        embedController?.append(viewController: newViewController)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            DispatchQueue.main.async(execute: {
                self.embedController?.remove(viewController: self.newViewController)
                self.fetchData()
            })
            super.viewWillAppear(true)
        }
//        UIApplication.shared.statusBarStyle = .lightContent
        setupNearByPeopleViewNotification()
        hideNavigationTabBar(false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        embedController?.remove(viewController: newViewController)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        defaultRadarView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        defaultRadarView.addPulse()
        self.delay(time: 4) {
            self.addChildViewControllers()
        }
    }
    
    //MARK:- Notification
    private func setupNearByPeopleViewNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNearByPeopleViewEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        view.addSubview(defaultRadarView)
        defaultRadarView.frame = view.bounds
        defaultRadarView.fillSuperView()
    }
//    private func delayTime(in seconds: Double) {
//        delay(time: seconds) {
//            self.addChildViewControllers()
//            //            self.view.addSubview(self.nearByPeopleView)
//            //            self.nearByPeopleView.fillSuperView()
//            //            self.nearByPeopleView.layoutIfNeeded()
//        }
//    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Radar"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = .mainBlue
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleSettingsButtonTap))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK:- Events
    @objc private func handleSettingsButtonTap() {
        let customTabBar = self.tabBarController as! CustomTabBarController
        customTabBar.animationTabBarHidden(true)
        navigationController?.pushViewController(RadarSettingsViewController(), animated: true)
    }
    
    @objc private func handleNearByPeopleViewEnterForeground() {
        UIView.animate(withDuration: 0.5, animations: {
            self.embedController?.remove(viewController: self.newViewController)
        }) { (true) in
            self.delay(time: 4, closure: {
                self.addChildViewControllers()
            })
        }
        
    }
    
    //MARK:- Helper Methods
    func delay(time: TimeInterval, closure: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: closure)
    }
    
    
}


