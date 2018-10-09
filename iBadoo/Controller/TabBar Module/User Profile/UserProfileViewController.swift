//
//  UserProfileViewController.swift
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
        view.testViewController = self
        return view
    }()
    
    lazy var userPopUpView: UserPopUpView = {
        let view = UserPopUpView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backGroundLightBlue
        setupLayouts()
        setupNavigation()
        dismissPopUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.animationTabBarHidden(true)
        }
    }
    private func dismissPopUp(){
//        userProfileView.scroll.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissPopUpTap)))
       userPopUpView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissPopUpTap)))
    }
    

    //MARK:- Layouts
    private func setupLayouts() {
        [userProfileView, userPopUpView].forEach { view.addSubview($0) }
        userProfileView.fillSuperView()
        
        userPopUpView.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: -245), size: .init(width: 240, height: 140))
    }
    
   
    
    ////MARK:- Navigation
    private func setupNavigation() {
        userProfileView.backAction = popViewController
        userProfileView.pushAction = pushViewController
        userProfileView.showPopUpAction = showPopUp
    }
    private func showPopUp() {
        userPopUpView.show()
    }
    @objc func dismissPopUpTap() {
        userPopUpView.hide()
    }
    
    @objc func handleShowCountriesButtonTap(sender: UIButton) {
        pushViewController()
    }
    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    private func pushViewController() {
        navigationController?.pushViewController(CountriesViewController(), animated: true)
    }
}

extension UserProfileViewController: UserProfileViewDelegate {
    func didSelectImage(image: Image, indexPath: IndexPath, count:Int) {
        let picturesDerailsViewController = PictureDetailsViewController()
        picturesDerailsViewController.image = image
        picturesDerailsViewController.index = indexPath.row + 1
        picturesDerailsViewController.totalImagesCounted = count
        navigationController?.pushViewController(picturesDerailsViewController, animated: true)
    }
}


