//
//  NavigationBarView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/27/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

protocol NavigationBarViewDelegate {
    func pushViewController()
    func popViewController()
}

class NavigationBarView: BaseUIView {
    
    var delegate: NavigationBarViewDelegate?
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_white"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "done"), for: .normal)
        button.addTarget(self, action: #selector(handleDoneButtonTap), for: .touchUpInside)
        return button
    }()
    private let titleHeaderLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Profile information", fontType: .regular, size: 22, color: .white)
        label.sizeToFit()
        return label
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        backgroundColor = .mainBlue
        setupLayouts()
    }
    
    //MARK:- Actions
    @objc private func handleBackButtonTap() {
        if let delegate = delegate {
            delegate.popViewController()
        }
    }
    
    @objc private func handleDoneButtonTap() {
        if let delegate = delegate {
            delegate.pushViewController()
        }
    }
    
    //MARK:- Layouts
    private func setupLayouts () {
        [backButton, titleHeaderLabel, doneButton].forEach {addSubview($0)}
        
        backButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 10, right: 0), size: .init(width: 13, height: 24))
        
        titleHeaderLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .zero, size: .init(width: 180, height: 26))
        titleHeaderLabel.anchorCenter(vertical: backButton.centerYAnchor, horizontal: centerXAnchor)
        
        doneButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 16), size: .init(width: 30, height: 35))
    }
}


























