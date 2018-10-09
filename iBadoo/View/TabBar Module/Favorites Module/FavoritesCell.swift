//
//  FavoritesCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/4/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class FavoritesCell: BaseCell {
    
    private let profileImageWidth: CGFloat = 61
    private let badgeProfileWidth: CGFloat = 24
    
    private lazy var profileImageView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "bitmap")
        profile.layer.cornerRadius = profileImageWidth / 2
        profile.layer.masksToBounds = true
        return profile
    }()
    private var badgeImageView: UIImageView = {
        let badge = UIImageView()
        badge.image = UIImage(named: "badge")
        return badge
    }()
    
    private let userFullName: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Ketea Roger,", fontType: .regular, size: 20, color: #colorLiteral(red: 0.02734689042, green: 0.02748729102, blue: 0.03151175752, alpha: 1))
        label.numberOfLines = 1
        return label
    }()
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "23 years old", fontType: .regular, size: 15, color: #colorLiteral(red: 0.02734689042, green: 0.02748729102, blue: 0.03151175752, alpha: 1))
        label.numberOfLines = 1
        return label
    }()
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Chisinau, Moldova", fontType: .regular, size: 16, color: #colorLiteral(red: 0.5459617376, green: 0.6012726426, blue: 0.7860836387, alpha: 1))
        label.numberOfLines = 1
        return label
    }()
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorColor
        return view
    }()
    private let bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorColor
        return view
    }()
    
    //MARK:- Life Cycle
    
    override func setupViews() {
        backgroundColor = .backGroundColor
        setupLayouts()
    }
    override var isHighlighted: Bool {
        didSet {
            backgroundColor =  isHighlighted ? .biggerCircleBlue : .backGroundLightBlue
        }
    }
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .biggerCircleBlue : .backGroundLightBlue
        }
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [profileImageView, badgeImageView, userFullName, ageLabel, regionLabel, topSeparatorView, bottomSeparatorView].forEach { contentView.addSubview($0) }
        
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: profileImageWidth, height: profileImageWidth))
        profileImageView.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        
        badgeImageView.anchor(top: nil, leading: nil, bottom: profileImageView.bottomAnchor, trailing: profileImageView.trailingAnchor, padding: .zero, size: .init(width: badgeProfileWidth, height: badgeProfileWidth))
        
        userFullName.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        ageLabel.anchor(top: nil, leading: userFullName.trailingAnchor, bottom: userFullName.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 25, bottom: 0, right: 0), size: .init(width: 0, height: 18))
        
        regionLabel.anchor(top: nil, leading: profileImageView.trailingAnchor, bottom: profileImageView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 5, right: 0), size: .init(width: 0, height: 19))
        
        topSeparatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        bottomSeparatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        
   
    }
}
