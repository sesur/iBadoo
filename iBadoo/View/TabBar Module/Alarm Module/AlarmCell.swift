//
//  AlarmCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/5/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class AlarmCell: BaseCell {
    
    private let prifileImageWidth: CGFloat = 61
    private let badgeProfileWidth: CGFloat = 24
    
    var onTapHandler: (() -> Void)?
    
    private lazy var profileImageView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "bitmap")
        profile.layer.cornerRadius = prifileImageWidth / 2
        profile.layer.masksToBounds = true
        return profile
    }()
    private var badgeImageView: UIImageView = {
        let badge = UIImageView()
        badge.image = UIImage(named: "badge_message")
        return badge
    }()
    private var notificationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "notification")
        return imageView
    }()
    
    private let userFullName: UILabel = {
        let user = UILabel()
        user.attributedText = AttributedStringHelper.getString(text: "Manuel Thompsom,", fontType: .regular, size: 20, color: #colorLiteral(red: 0.02734689042, green: 0.02748729102, blue: 0.03151175752, alpha: 1))
        user.numberOfLines = 1
        return user
    }()
    private let ageLabel: UILabel = {
        let age = UILabel()
        age.attributedText = AttributedStringHelper.getString(text: "28 years old", fontType: .regular, size: 15, color: #colorLiteral(red: 0.02734689042, green: 0.02748729102, blue: 0.03151175752, alpha: 1))
        age.numberOfLines = 1
        return age
    }()
    private let statusLabel: UILabel = {
        let status = UILabel()
        status.attributedText = AttributedStringHelper.getString(text: "Now you are mutual friend", fontType: .regular, size: 16, color: #colorLiteral(red: 0.5459617376, green: 0.6012726426, blue: 0.7860836387, alpha: 1))
        status.numberOfLines = 1
        return status
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
    lazy var rejectButton: Button = {
        let reject = Button()
        let customAttributtedText = AttributedStringHelper.getString(text: Alarm.Button.reject.rawValue, fontType: .regular, size: 17, color: .mainBlue)
        reject.setAttributedTitle(customAttributtedText, for: .normal)
        reject.setImage(UIImage(named: "close_white")?.withRenderingMode(.alwaysOriginal), for: .selected)
        reject.setImage(UIImage(named:"close_blue")?.withRenderingMode(.alwaysOriginal), for: .normal)
        reject.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        reject.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        reject.addTarget(self, action: #selector(acceptedButtonPressed(sender: )), for: .touchUpInside)
        reject.tag = 1
        return reject
    }()
    
    lazy var acceptButton: Button = {
        let accept = Button()
        let customAttributedText = AttributedStringHelper.getString(text: Alarm.Button.accept.rawValue, fontType: .regular, size: 17, color: .mainBlue)
        accept.setAttributedTitle(customAttributedText, for: .normal)
        accept.setImage(UIImage(named:"check_white")?.withRenderingMode(.alwaysOriginal), for: .selected)
        accept.setImage(UIImage(named:"check_blue")?.withRenderingMode(.alwaysOriginal), for: .normal)
        accept.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        accept.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        accept.addTarget(self, action: #selector(acceptedButtonPressed(sender: )), for: .touchUpInside)
        accept.tag = 0
        return accept
    }()
    
    //        print("Accepted button pressed ")
    
    //       guard let handler = self.onTapHandler else { return }
    //        handler()
    
//    if !sender.isSelected {
//    enableButtonState(sender: sender)
//    } else {
//    disableButtonState(sender: sender)
//    }
//    sender.isSelected = !sender.isSelected
    
    fileprivate func enableButtonState(sender: UIButton){
        if !sender.isSelected && sender.tag == 1 {
            sender.backgroundColor = .mainBlue
            let customAttributedText = AttributedStringHelper.getString(text: Alarm.Button.reject.rawValue, fontType: .regular, size: 17, color: .white)
            sender.setAttributedTitle(customAttributedText, for: .normal)
        }
        if !sender.isSelected && sender.tag == 0{
            sender.backgroundColor = .mainBlue
            let customAttributedText = AttributedStringHelper.getString(text: Alarm.Button.accept.rawValue, fontType: .regular, size: 17, color: .white)
            sender.setAttributedTitle(customAttributedText, for: .normal)
        }
    }
    fileprivate func disableButtonState(sender: UIButton) {
        if sender.isSelected && sender.tag == 1 {
            sender.backgroundColor = .clear
            let customAttributedText = AttributedStringHelper.getString(text: Alarm.Button.reject.rawValue, fontType: .regular, size: 17, color: .mainBlue)
            sender.setAttributedTitle(customAttributedText, for: .normal)
        }
        if sender.isSelected && sender.tag == 0{
            sender.backgroundColor = .clear
            let customAttributedText = AttributedStringHelper.getString(text: Alarm.Button.accept.rawValue, fontType: .regular, size: 17, color: .mainBlue)
            sender.setAttributedTitle(customAttributedText, for: .normal)
        }
    }
    
    @objc private func acceptedButtonPressed(sender: UIButton) {
        for (index, _) in [acceptButton, rejectButton].enumerated() {
            if index == sender.tag {
                enableButtonState(sender: sender)
            } else {
                disableButtonState(sender: sender)
            }
           disableButtonState(sender: sender)
        }
        sender.isSelected = !sender.isSelected
    }
    
//    @objc private func rejectedButtonPressed(sender: UIButton) {
//        if sender.tag == 0 && !sender.isSelected {
//            rejectButton.isSelected = true
//
////            enableButtonState(sender: sender)
//        } else if sender.tag == 1 && sender.isSelected{
//            disableButtonState(sender: sender)
//        }
//        sender.isSelected = !sender.isSelected
//    }
    
    
    
    override func prepareForReuse() {
        acceptButton.didTouchUpInside = nil
        rejectButton.didTouchUpInside = nil
    }
    
    override func setupViews() {
        backgroundColor = .backGroundColor
        setupLayouts()
    }
    private func setupLayouts() {
        [profileImageView, badgeImageView, notificationImageView, userFullName, userFullName, ageLabel, statusLabel, topSeparatorView, bottomSeparatorView].forEach { contentView.addSubview($0) }
        
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: prifileImageWidth, height: prifileImageWidth))
        //        profileImageView.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -46).isActive = true
        
        badgeImageView.anchor(top: nil, leading: nil, bottom: profileImageView.bottomAnchor, trailing: profileImageView.trailingAnchor, size: .init(width: badgeProfileWidth, height: badgeProfileWidth))
        
        notificationImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: 10, height: 10))
        notificationImageView.anchorCenter(vertical: profileImageView.centerYAnchor, horizontal: nil)
        
        userFullName.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .init(width: 0, height: 23))
        
        statusLabel.anchor(top: userFullName.bottomAnchor, leading: userFullName.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        
        ageLabel.anchor(top: nil, leading: userFullName.trailingAnchor, bottom: userFullName.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 25, bottom: 0, right: 0), size: .init(width: 0, height: 18))
        
        topSeparatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        bottomSeparatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        
        let buttonStatusStackView = UIStackView(arrangedSubviews: [acceptButton, rejectButton])
        addSubview(buttonStatusStackView)
        buttonStatusStackView.axis = .horizontal
        buttonStatusStackView.distribution = .fillEqually
        buttonStatusStackView.spacing = 30
        
        buttonStatusStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 32, bottom: 26, right: 32), size: .init(width: 0, height: 48))
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
}
