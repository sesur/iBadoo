//
//  MyProfileViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
//import FirebaseDatabase
import FirebaseAuth
import FacebookCore
import FacebookLogin

class MyProfileViewController: UIViewController {
    
    private lazy var myProfileView: MyProfileView = {
        let view = MyProfileView()
        view.delegate = self
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        view.layoutIfNeeded()
        super.viewDidLoad()
        setupNavigationBar()
        setupLayouts() 
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async(execute: {
                DataModelService.sharedInstance.fetchUserFromFirebase(completion: { [weak self] (user) in
                    self?.myProfileView.userObserver = user
                })
            })
        }
        super.viewWillAppear(false)
//        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
//    func fetchUserFromFirebase() {
//        if Auth.auth().currentUser != nil {
//            guard let uid = Auth.auth().currentUser?.uid else {return}
//            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
////                print(snapshot)
//
//               guard let dictionaryData = snapshot.value as? [String : Any] else {return}
//                let user = CurrentUser(uid: uid, dictionaryValues: dictionaryData)
//                self.myProfileView.userObserver = user
//            }) { (error) in
//                print(error.localizedDescription)
//            }
//        }
//    }

    
    
    
    
    
//    func fetchImageFrom(_ url: String?) {
//        if let url = url {
//            guard let url = URL(string: url) else {return}
//            let request = URLRequest(url: url)
//            URLSession.shared.dataTask(with: request) { (data, response, error) in
//                print(data)
//            }
////            URLSession.shared.dataTask(with: url) { (data, response, error) in
////                if let error = error {
////                    print(error.localizedDescription)
////                    return
////                }
////                guard let data = data else {return}
////                guard let image = UIImage(data: data) else {return}
////                print(image)
////
////                //            self.myProfileView.userObserver =
////                }.resume()
//          }
//        }

        
 
    
    
    
    //MARK:- Layouts
    private func setupLayouts(){
        view.addSubview(myProfileView)
        myProfileView.fillSuperView()
    }
    private func setupNavigationBar(){
        navigationItem.title = "My profile"
        navigationController?.navigationBar.barTintColor = .mainBlue
        navigationController?.navigationBar.tintColor = .white
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}

extension MyProfileViewController: MyProfileDelegate {
    func pushViewController(data: MyProfileModel?, indexPath: IndexPath) {
        let profileItem = myProfileView.settingArray[indexPath.item]
        
        let aboutMeController = AboutMeViewController()
        let myProfileViewController = MyProfilePictureViewController()
        let settingsViewController = SettingsViewController()
        
        
        //        let initialViewController = LoginViewController()
        //        let initialViewController = SwipeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        var viewController = UIViewController()
        switch indexPath.item {
        case 0:
            viewController = aboutMeController
            aboutMeController.aboutMeItem = profileItem
            pushToSelectedViewContlroller(viewController)
        case 1:
            viewController = myProfileViewController
            myProfileViewController.profilePictureItem = profileItem
            pushToSelectedViewContlroller(viewController)
        case 2:
            viewController = settingsViewController
            settingsViewController.settingsItem = profileItem
            pushToSelectedViewContlroller(viewController)
            
        case 3: logOut(viewController)
            
        default: break
        }
        
    }
    
    func pushToSelectedViewContlroller(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func logOut(_ fromViewController: UIViewController) {
        print(" ------ log out button pressed ")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let initialViewController = SwipeViewController(collectionViewLayout: layout)
        
        handleLogoutTap(initialViewController)
    }
    
    @objc func handleLogoutTap(_ viewController: UIViewController) {
        let signOutAction = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            do {
                try Auth.auth().signOut()
                print("Log out from Firebase")
                LoginManager().logOut()
                print("Log out from Facebook")
//                UserDefaults.standard.set(false, forKey: "isLoggedIn")
//                UserDefaults.standard.synchronize()
                
                self.navigationController?.root(viewController: viewController, transitionType: "fromRight", duration: 0.4)
                if let customTabBar = self.tabBarController as? CustomTabBarController {
                    customTabBar.animationTabBarHidden(true)
                }
                
            } catch let error {
                Service.showAlert(onViewController: self, style: .alert, title: "Sign Out Error", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        Service.showAlert(onViewController: self, style: .actionSheet, title: nil, message: nil, actions: [signOutAction, cancelAction], completion: nil)
        
    }
    
}



