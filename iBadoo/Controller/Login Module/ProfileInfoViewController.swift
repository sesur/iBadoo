//
//  ProfileInfoViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/22/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class ProfileInfoViewController: UIViewController {
    
    private let navigationBarHeight: CGFloat = 64
    
//    private lazy var navigationBarView: NavigationBarView = {
//        let navigationBarView = NavigationBarView()
//        navigationBarView.delegate = self
//        return navigationBarView
//    }()
    private let scrollView: UIScrollView = {
        var scroll = UIScrollView()
        return scroll
    }()
    private var scrollContentView: ProfileInfoView = {
        let view = ProfileInfoView()
        return view
    }()

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        dismissKeyboard()
    }
    private func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .lightContent
        setupNavigation()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        UIApplication.shared.statusBarStyle = .default
    }
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Profile information"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "done"), style: .plain, target: self, action: #selector(handleDoneButtonTap))]
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        //navigationBarView,
        [ scrollView].forEach {view.addSubview($0)}
        [scrollContentView].forEach {scrollView.addSubview($0)}
//        navigationBarView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: navigationBarHeight))

        //       navigationBarView.bottomAnchor
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .zero)
        
        scrollContentView.fillSuperView()
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true // the most important feature
    }
    
    
}

//MARK:- Navigation
extension ProfileInfoViewController: NavigationBarViewDelegate {
    
    @objc private func handleDoneButtonTap() {
        navigationController?.initRootViewController(viewController: CustomTabBarController(), transitionType: "fromBottom" , duration: 0.3)
    }
    
    ///no need them
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    func pushViewController() {
      navigationController?.initRootViewController(viewController: CustomTabBarController(), transitionType: "fromBottom" , duration: 0.3)
    }
}
















