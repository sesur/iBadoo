//
//  BaseMessagesController.swift
//  iBadoo
//
//  Created by Sergiu on 8/28/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import FirebaseCore



class BaseMessagesController: UIViewController {
    
    
    //MARK: ChildViewController
    private var embedViewControler: EmbedController?
   let allMessagesController : AllMessagesController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let viewController = AllMessagesController(collectionViewLayout: layout)
        return viewController
    }()
    

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayouts()
        addChildViewController()
        
    }
    
    private func addChildViewController() {
        embedViewControler = EmbedController(rootViewController: self)
        allMessagesController.view.fillSuperView()
        embedViewControler?.append(viewController: allMessagesController)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(false, animated: true)
//        print("viewWillAppear")
        
        setupNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupNavigationBar(){
        navigationItem.title = "Inbox"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .mainBlue
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
    }
    
    
}





//extension BaseMessagesController: InboxViewDelegate {
//    func pushViewController() {
//        let layout = UICollectionViewFlowLayout()
//        let chatLogVC = ChatLogViewController(collectionViewLayout: layout)
//        self.navigationController?.pushViewController(chatLogVC, animated: true)
//    }
//
//    func pushViewController(user: User, indexPath: IndexPath) {
//
//    }
//
//    func pushViewController(user: CurrentUser, indexPath: IndexPath) {
//        let layout = UICollectionViewFlowLayout()
//        let chatLogVC = ChatLogViewController(collectionViewLayout: layout)
//
//        self.navigationController?.pushViewController(chatLogVC, animated: true)
//
//        hideNavigationTabBar(true)
//
//    }
//
//}









