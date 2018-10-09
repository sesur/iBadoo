//
//  MainNavigationController.swift
//  iBadoo
//
//  Created by Sergiu on 8/2/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backGroundLightBlue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if isLoggedIn() {
            viewControllers = [CustomTabBarController()]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        if Auth.auth().currentUser?.uid == nil {
//            return UserDefaults.standard.bool(forKey: "isLoggedIn")
            return false
        }
            else {
            return true
        }
    }
    
    @objc func showLoginController() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipeViewController = SwipeViewController(collectionViewLayout: layout)
        pushViewController(swipeViewController, animated: false)
    }
}




