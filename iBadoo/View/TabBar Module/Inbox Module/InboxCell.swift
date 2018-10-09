
//  InboxCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/2/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InboxCell: BaseCell {
    
    private let imageWidth: CGFloat = 61
    
    var message: CurrentMessages? {
        didSet {
            guard let unwrappedMessage = message else { return }
            messageLabel.text = unwrappedMessage.message
            
            self.setupNameAndProfileImage()
            if let seconds = unwrappedMessage.timestamp {
                let timestamp = Date(timeIntervalSince1970: TimeInterval(seconds))
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "hh:mm a"
                dateLabel.text = dateFormater.string(from: timestamp) //timestamp.description
            }
        }
    }
    
    
    private func setupNameAndProfileImage() {
        if let id  = message?.chatPartnerId() {
            let reference = Database.database().reference().child("users").child(id)
            reference.observeSingleEvent(of: .value, with: { (snapshot) in
                if let  dictionary = snapshot.value as? [String: Any] {
                    self.userFullName.text = dictionary["fullName"] as? String
                    if let profileImageUrl = dictionary["imageUrl"] as? String {
                        self.profileImageView.loadImageUsingCacheWith(profileImageUrl)
                    }
                }
            }, withCancel: nil)
        }
    }
    
    
//    var message: Message? {
//        didSet {
//            guard let unwrappedMessage = message else { return }
//            userFullName.text = unwrappedMessage.userR?.name
//            messageLabel.text = unwrappedMessage.text
//
//            if let profileImage = unwrappedMessage.userR?.profileImageName {
//                profileImageView.image = UIImage(named: profileImage)
//            }
//            if let date = unwrappedMessage.date {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "h:mm a"
//                let elapsedTimeInSeconds = Date().timeIntervalSince(date)
//                let secondInDay: TimeInterval = 60 * 60 * 24
//
//                if elapsedTimeInSeconds > 7 * secondInDay{
//                    dateFormatter.dateFormat = "MM/dd/yy"
//                } else if elapsedTimeInSeconds > secondInDay {
//                    dateFormatter.dateFormat = "EEE"
//                }
//                dateLabel.text = dateFormatter.string(from: date)
//            }
//        }
//    }
    
    private lazy var profileImageView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "bitmap")
        profile.layer.cornerRadius = imageWidth / 2
        profile.layer.masksToBounds = true
        return profile
    }()
     let userFullName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
            userFullName.textColor = isHighlighted ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            messageLabel.textColor = isHighlighted ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            dateLabel.textColor = isHighlighted ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .biggerCircleBlue : .backGroundLightBlue
            userFullName.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            messageLabel.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            dateLabel.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [profileImageView, userFullName, dateLabel, messageLabel, topSeparatorView, bottomSeparatorView].forEach { contentView.addSubview($0) }
        
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: imageWidth, height: imageWidth))
        profileImageView.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        
        userFullName.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        dateLabel.anchor(top: nil, leading: nil, bottom: userFullName.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20), size: .init(width: 0, height: 18))
        
        messageLabel.anchor(top: nil, leading: profileImageView.trailingAnchor, bottom: profileImageView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 5, right: 10), size: .init(width: 0, height: 19))
        
        topSeparatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        
        bottomSeparatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
    }
}
