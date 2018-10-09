//
//  AboutMeViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/16/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {
    
    var aboutMeItem: MyProfileModel? {
        didSet {
            navigationItem.title = aboutMeItem?.nameLabel.rawValue
        }
    }
    
    //MARK:- Proprietes
    private lazy var relashionshipView: MyRelashionshipView = {
        let view = MyRelashionshipView()
        return view
    }()
    private let knowLanguageView: MyKnowLanguageView = {
        let view = MyKnowLanguageView()
        return view
    }()
    private let interestsView: MyInterestsView = {
        let view = MyInterestsView()
        return view
    }()
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dismissKeyboard()
        setupNavigation()
        setupLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideNavigationTabBar(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        hideNavigationTabBar(false)
    }
    
    
    private func setupNavigation(){
        navigationController?.navigationBar.tintColor = .white
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "done"), style: .plain, target: self, action: #selector(handleDoneTap))]
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    //MARK:- Actions
    @objc private func handleDoneTap() {
        navigationController?.popViewController(animated: true)
    }
    private func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        
        view.addSubview(scrollView)
        scrollView.fillSuperView()
        
        scrollView.addSubview(contentView)
        contentView.fillSuperView()
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true // the most important feature
        
        [interestsView, relashionshipView, knowLanguageView,].forEach { contentView.addSubview($0) }
        
        relashionshipView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 210))
        
        knowLanguageView.anchor(top: relashionshipView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 254))
        
        interestsView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 460, left: 0, bottom: 8, right: 0), size: .init(width: 0, height: 200))
    }
}



