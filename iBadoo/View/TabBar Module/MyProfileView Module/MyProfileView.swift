//
//  MyProfileView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/15/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import FirebaseCore

protocol MyProfileDelegate {
    func pushViewController(data: MyProfileModel?, indexPath: IndexPath)
}

class MyProfileView: BaseUIView {
    
    private let imageFrameSize: CGFloat = 120
    private let cellId = "cellId"
    
    var delegate: MyProfileDelegate?
    
    let settingArray: [MyProfileModel] = {
        let object = [MyProfileModel(nameLabel: Text.aboutMe, imageName: MyProfile.Image.next.rawValue),
                      MyProfileModel(nameLabel: Text.profilePictures, imageName: MyProfile.Image.next.rawValue),
                      MyProfileModel(nameLabel: Text.settings, imageName: MyProfile.Image.next.rawValue),
                      MyProfileModel(nameLabel: Text.logOut, imageName: MyProfile.Image.none.rawValue)
                      ]
        return object
    }()
    
    
    var userObserver: CurrentUser? {
        didSet {
            guard let unwrappedCurrentUser = userObserver else { return }
            guard let fullName = unwrappedCurrentUser.fullName else {return}
            fullNameLabel.attributedText = AttributedStringHelper.getString(text: fullName, fontType: .regular, size: 24, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) == AttributedStringHelper.getString(text: "", fontType: .regular, size: 24, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) ? AttributedStringHelper.getString(text: "Name: NA", fontType: .regular, size: 24, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : AttributedStringHelper.getString(text: fullName, fontType: .regular, size: 24, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            myProfileImageView.loadImageUsingCacheWith(unwrappedCurrentUser.profilePictureUrl)
        }
    }

    lazy var myProfileImageView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = imageFrameSize / 2
//        img.image = UIImage(named: "radar")
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    let fullNameLabel: UILabel = {
        let label = UILabel()
//        label.attributedText = AttributedStringHelper.getString(text: "Vadim Hariton", fontType: .regular, size: 24, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        label.sizeToFit()
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyProfileCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
        setupLayout() 
    }
    private func setupLayout(){
        [myProfileImageView, fullNameLabel, collectionView].forEach { addSubview($0) }
        
        myProfileImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 85, left: 0, bottom: 0, right: 0), size: .init(width: imageFrameSize, height: imageFrameSize))
        myProfileImageView.anchorCenter(vertical: nil, horizontal: centerXAnchor)
        
        fullNameLabel.anchor(top: myProfileImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .zero)
        fullNameLabel.anchorCenter(vertical: nil, horizontal: myProfileImageView.centerXAnchor)
        
        collectionView.anchor(top: fullNameLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .zero)
    }
}


extension MyProfileView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = settingArray[indexPath.item]
        guard let delegate = delegate else {return}
        delegate.pushViewController(data: data, indexPath: indexPath)
    }
}

extension MyProfileView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MyProfileCell {
            cell.myProfileCellObserver = settingArray[indexPath.item]
            return cell
        }
        return MyProfileCell()
    }
}

extension MyProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 65)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
