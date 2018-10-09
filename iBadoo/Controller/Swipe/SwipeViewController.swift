//
//  SwipeViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/4/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class SwipeViewController: UICollectionViewController {
    let swipingVCIdentifier = "cellId"
    //        var registerAction: () -> () = { }
    //        var loginAction: () -> () = { }
    
    let swipingPagesArray = [
        Page(imageName: "start", headerText: "Make new friends trough nearby location", bodyText: "Join in appand make new conections\n and more friends"),
        Page(imageName: "radar", headerText: "Find nearby people", bodyText: "We searching new people of near you ... "),
        Page(imageName: "vip", headerText: "V.I.P. members special services", bodyText: "Better radar localization, private account, incognito mode  and more ... "),
        Page(imageName: "radar", headerText: "Find nearby people", bodyText: "We searching new people of near you ... ")
    ]
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton()
        let customAttributtedText = AttributedStringHelper.getString(text: ButtonText.register.rawValue, fontType: .regular, size: 20, color: .white)
        button.backgroundColor = .mainBlue
        button.setAttributedTitle(customAttributtedText, for: .normal)
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton()
        let customAttributedText = AttributedStringHelper.getString(text: ButtonText.login.rawValue, fontType: .regular, size: 20, color: .mainBlue)
        button.setAttributedTitle(customAttributedText, for: .normal)
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.currentPage = 0
        page.numberOfPages = swipingPagesArray.count
        page.currentPageIndicatorTintColor = .mainBlue
        page.pageIndicatorTintColor = #colorLiteral(red: 0.7453632951, green: 0.7963940501, blue: 0.8933854699, alpha: 1)
        return page
    }()
    
    private let bottomNavigationView: CustomUIView = {
        let view = CustomUIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private let labelMessage: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = AttributedStringHelper.getString(text: MainLoginTextMessage.mainLabelMessage.rawValue, fontType: .regular, size: 15, color: #colorLiteral(red: 0.6316630244, green: 0.6788004637, blue: 0.7757177949, alpha: 1))
        label.sizeToFit()
        return label
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupCollectionView() 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        UIApplication.shared.statusBarStyle = .default
        setupNavigationBar()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .mainBlue
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
    }
    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: swipingVCIdentifier)
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
    
    //MARK:- Actions
    @objc private func handleRegisterButton() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc private func handleLoginButton() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    //MARK:- Layouts
    fileprivate func setupLayouts()
    {
        let bottomNavigationStack = UIStackView(arrangedSubviews: [bottomNavigationView])
        let pageControllStack = UIStackView(arrangedSubviews: [pageControl])
        [pageControllStack, bottomNavigationStack].forEach {view.addSubview($0)}
        bottomNavigationStack.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: 118))
        pageControllStack.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: bottomNavigationStack.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 140, right: 30), size: .init(width: 0, height: 10))
        
        let labelMessageStack = UIStackView(arrangedSubviews: [labelMessage])
        let buttonsStack = UIStackView(arrangedSubviews: [registerButton, loginButton])
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 20
        buttonsStack.alignment = .fill
        
        let bottomStack = UIStackView(arrangedSubviews: [labelMessageStack, buttonsStack])
        [bottomStack].forEach {bottomNavigationStack.addSubview($0)}
        bottomStack.axis = .vertical
        bottomStack.distribution = .fillProportionally
        bottomStack.spacing = 10
        
        bottomStack.anchor(top: bottomNavigationStack.topAnchor, leading: bottomNavigationStack.leadingAnchor, bottom: bottomNavigationStack.bottomAnchor, trailing: bottomNavigationStack.trailingAnchor, padding: .init(top: 15, left: 30, bottom: 20, right: 30), size: .zero)
    }
}
