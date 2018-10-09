//
//  NeabyPeopleCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/31/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import SwipeCellKit


class NeabyPeopleCell: SwipeCollectionViewCell {
    
    var animator: Any?
    private let indicatorView = IndicatorView(frame: .zero)
    private let imageWidth: CGFloat = 61
    
        var deleteFriend = false {
            didSet {
                indicatorView.transform = deleteFriend ? CGAffineTransform.identity : CGAffineTransform.init(scaleX: 0.001, y: 0.001)
            }
        }
    
    var nearbyPeopleObserver: CurrentUser? {
        didSet {
            guard let allUsers = nearbyPeopleObserver  else {return}
            guard let fullName = allUsers.fullName else {return}
            userFullName.attributedText = AttributedStringHelper.getString(text: fullName, fontType: .regular, size: 20, color: #colorLiteral(red: 0.02734689042, green: 0.02748729102, blue: 0.03151175752, alpha: 1))
            profileImageView.loadImageUsingCacheWith(allUsers.profilePictureUrl)
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "bitmap")
        profile.layer.cornerRadius = imageWidth / 2
        profile.layer.masksToBounds = true
        return profile
    }()
    private lazy var badgeImageView: UIImageView = {
        let badge = UIImageView()
        badge.image = UIImage(named: "placeholder")
        return badge
    }()
     let userFullName: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Ketea Roger,", fontType: .regular, size: 20, color: #colorLiteral(red: 0.02734689042, green: 0.02748729102, blue: 0.03151175752, alpha: 1))
        label.numberOfLines = 0
        return label
    }()
    private let ageLabel: UILabel = {
        let age = UILabel()
        age.attributedText = AttributedStringHelper.getStringNoneColor(text: "27 years old", fontType: .regular, size: 15)
        age.numberOfLines = 1
        return age
    }()
    private let distanceLabel: UILabel = {
        let distance = UILabel()
        distance.attributedText = AttributedStringHelper.getString(text: "in 24 meters", fontType: .regular, size: 16, color: .mainBlue)
        distance.numberOfLines = 1
        return distance
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGroundLightBlue
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = .backGroundLightBlue
            //            contentView.backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
        }
    }
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = .backGroundLightBlue
            //            contentView.backgroundColor = isSelected ? UIColor.lightGray : UIColor.white
        }
    }
    
    //MARK:- Events
    
    
    func setUnselected(_ unselected: Bool, animated: Bool) {
        let closure = {
             self.deleteFriend = unselected
        }
        
        if #available(iOS 10, *), animated {
            var localAnimator = self.animator as? UIViewPropertyAnimator
            localAnimator?.stopAnimation(true)
            
            localAnimator = unselected ? UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.4) : UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1.0)
            localAnimator?.addAnimations(closure)
            localAnimator?.startAnimation()
            
            self.animator = localAnimator
        } else {
            closure()
        }
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [profileImageView, badgeImageView, userFullName, ageLabel, distanceLabel, topSeparatorView, bottomSeparatorView].forEach { contentView.addSubview($0) }
        
        
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: imageWidth, height: imageWidth))
        profileImageView.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        
        badgeImageView.anchor(top: nil, leading: userFullName.leadingAnchor, bottom: profileImageView.bottomAnchor, trailing: nil, padding: .zero, size: .init(width: 14, height: 21))
        
        userFullName.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        ageLabel.anchor(top: nil, leading: userFullName.trailingAnchor, bottom: userFullName.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .init(width: 0, height: 18))
        
        distanceLabel.anchor(top: nil, leading: badgeImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 0, height: 19))
        distanceLabel.anchorCenter(vertical: badgeImageView.centerYAnchor, horizontal: nil)
        
        topSeparatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        
        bottomSeparatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        
    }
    
//        func setupIndicatorView() {
//            indicatorView.translatesAutoresizingMaskIntoConstraints = false
//            indicatorView.color = tintColor
//            indicatorView.backgroundColor = .clear // .bgLightBlue//
//            contentView.addSubview(indicatorView)
//
//            let size: CGFloat = 12
//            indicatorView.widthAnchor.constraint(equalToConstant: size).isActive = true
//            indicatorView.heightAnchor.constraint(equalTo: indicatorView.widthAnchor).isActive = true
//            indicatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
//            indicatorView.centerYAnchor.constraint(equalTo: userFullName.centerYAnchor).isActive = true
//        }
    
    
}


