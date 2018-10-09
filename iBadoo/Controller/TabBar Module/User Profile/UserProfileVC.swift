//
//  UserProfileVC.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/26/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    lazy var userProfileView: UserProfileView = {
        let view = UserProfileView()
        view.delegate = self
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        setupNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.animationTabBarHidden(true)
        }
    }

    //MARK:- Layouts
    private func setupLayouts() {
        view.addSubview(userProfileView)
        userProfileView.fillSuperView()
    }
    
    /// test Navigation
    @objc func handleMyTapButtonTap(sender: UIButton) {
        pushViewController()
    }
    
    ////MARK:- Navigation
    private func setupNavigation() {
        userProfileView.backAction = popViewController
        userProfileView.pushAction = pushViewController
    }
    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    private func pushViewController() {
        navigationController?.pushViewController(CountriesVC(), animated: true)
    }
//
//    @objc func handlePhotoCellTap(sender: UIButton) {
//        navigationController?.pushViewController(PictureDetailsVC(), animated: true)
//    }
}


extension UserProfileViewController:  UserPhotoProtocol {
    func navigateToPictureDetailsVC(image: Image, withIndex: IndexPath, totalImages: Int){
        let picturesDerailsViewController = PictureDetailsViewController()
        picturesDerailsViewController.image = image
        picturesDerailsViewController.index = withIndex.row + 1
        picturesDerailsViewController.totalImagesCounted = totalImages
       navigationController?.pushViewController(picturesDerailsViewController, animated: true)
        
    }
    
}

extension UserProfileViewController: UserProfileViewDelegate {
    func didSelectImage(image: Image, indexpath:IndexPath, count:Int) {
        navigateToPictureDetailsVC(image: image, withIndex: indexpath, totalImages: count)
    }
}


