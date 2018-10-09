//
//  CountriesViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/28/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        return view
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_white"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let titleHeaderLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Visited countries", fontType: .regular, size: 22, color: .white)
       label.sizeToFit()
        return label
    }()
    
    private let countriesView: UserCountriesView = {
        let view = UserCountriesView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK:- Actions
    @objc private func handleBackButtonTap(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Layouts
    private func setupLayouts(){
        [countriesView, navigationView].forEach {view.addSubview($0)}
        
        navigationView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: 64))
        
        countriesView.anchor(top: navigationView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .zero)
        
        [titleHeaderLabel, backButton].forEach { navigationView.addSubview($0)}
        backButton.anchor(top: nil, leading: navigationView.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 10, right: 0), size: .init(width: 14, height: 24))
        
        titleHeaderLabel.anchor(top: backButton.topAnchor, leading: nil, bottom: backButton.bottomAnchor, trailing: nil, padding: .zero, size: .zero)
        titleHeaderLabel.anchorCenter(vertical: nil, horizontal: navigationView.centerXAnchor)  
    }
}
