//
//  InboxViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import CoreData

class InboxViewController: UIViewController {
    
    private lazy var inboxView: InboxView = {
        let view = InboxView()
        view.delegate = self
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayouts()
        
        // simulate add new User
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "simulate", style: .done, target: self, action: #selector(addUser))
    }
    
//    @objc private func addUser() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let dodon = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
//        dodon.name = "Igor Dodon"
//        dodon.profileImageName = "dodon"
//
//        InboxView.createMessageWith(text: "Nu va jucati cu focul ... ", user: dodon, minutesAgo: 0, context: context)
//
//        let putin = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
//        putin.name = "Vladimir Putin"
//        putin.profileImageName = "putin"
//
//        InboxView.createMessageWith(text: "Intrebati-l pe Igoras, el stie mai bine ...  ", user: putin, minutesAgo: 0, context: context)
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    private func setupNavigationBar(){
//        navigationItem.title = "Inbox"
        self.title = "Inbox"
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .mainBlue
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        view.addSubview(inboxView)
        inboxView.fillSuperView()
    }
    
    
}

//MARK:- Navigation
extension InboxViewController: InboxViewDelegate {
    func pushViewController() {
        let layout = UICollectionViewFlowLayout()
        let chatLogVC = ChatLogViewController(collectionViewLayout: layout)
        self.navigationController?.pushViewController(chatLogVC, animated: true)
    }
    
    func pushViewController(user: CurrentUser, indexPath: IndexPath) {
        
    }
    
    func pushToChatViewController(user: CurrentUser, indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let chatLogVC = ChatLogViewController(collectionViewLayout: layout)
        
        
//        chatLogVC.chatVC = self
//        if let user = inboxView.fetchedResultController.object(at: indexPath) as? User {
//            chatLogVC.user = user
//        }
        
        self.navigationController?.pushViewController(chatLogVC, animated: true)
        
        hideNavigationTabBar(true)
        
//        if let customTabBar = self.tabBarController as? CustomTabBarController {
//            customTabBar.animationTabBarHidden(true)
//        }
    }
    
    
    
    func pushViewController(user: User, indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let chatLogVC = ChatLogViewController(collectionViewLayout: layout)
//            chatLogVC.chatVC = self
//        if let user = inboxView.fetchedResultController.object(at: indexPath) as? User {
//            chatLogVC.user = user
//        }
       
        self.navigationController?.pushViewController(chatLogVC, animated: true)
        
        hideNavigationTabBar(true)
        
//        if let customTabBar = self.tabBarController as? CustomTabBarController {
//            customTabBar.animationTabBarHidden(true)
//        }
    }
}





