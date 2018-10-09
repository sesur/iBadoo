//
//  PhotoView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/26/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserPhotoView: BaseUIView {
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "hariton")
        return iv
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1030479754)
        return view
    }()
    private let userFullName: UILabel = {
        let user = UILabel()
        user.attributedText = AttributedStringHelper.getString(text: "Hariton Vadim,", fontType: .regular, size: 20, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        user.numberOfLines = 1
        return user
    }()
    private let ageLabel: UILabel = {
        let age = UILabel()
        age.attributedText = AttributedStringHelper.getString(text: "23 years old", fontType: .regular, size: 15, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        age.numberOfLines = 1
        return age
    }()
    private let regionLabel: UILabel = {
        let region = UILabel()
        region.attributedText = AttributedStringHelper.getString(text: "Chisinau, Moldova", fontType: .regular, size: 16, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        region.sizeToFit()
        return region
    }()
    
    override func setupViews() {
        super.setupViews()
        setupLayouts()
        
    }
    private func setupLayouts() {
        [photoImageView].forEach { addSubview($0) }
        photoImageView.fillSuperView()
        
        [containerView].forEach { photoImageView.addSubview($0) }
        containerView.anchor(top: nil, leading: photoImageView.leadingAnchor, bottom: photoImageView.bottomAnchor, trailing: photoImageView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 100))
        self.containerView.setGradientBackground(topColor: .white, bottomColor: .black)
        
        [userFullName, ageLabel, regionLabel].forEach {containerView.addSubview($0)}
        regionLabel.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 28, right: 0), size: .zero)
        userFullName.anchor(top: nil, leading: regionLabel.leadingAnchor, bottom: regionLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .zero)
        
        ageLabel.anchor(top: nil, leading: userFullName.trailingAnchor, bottom: userFullName.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .zero)
        
        
    }
}
