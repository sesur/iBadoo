//
//  UserPhotoView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/26/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserPhotoView: BaseUIView {
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "hariton")
        return imageView
    }()
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1030479754)
        return view
    }()
    private let userFullName: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Hariton Vadim,", fontType: .regular, size: 20, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        label.numberOfLines = 1
        return label
    }()
    private let userAgeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "23 years old", fontType: .regular, size: 15, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        label.numberOfLines = 1
        return label
    }()
    private let userRegionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Chisinau, Moldova", fontType: .regular, size: 16, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        label.sizeToFit()
        return label
    }()

    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    
    //MARK: Layouts
    private func setupLayouts() {
        [userPhotoImageView, containerView ].forEach{addSubview($0)}
        userPhotoImageView.fillSuperView()
        
        containerView.anchor(top: nil, leading: userPhotoImageView.leadingAnchor, bottom: userPhotoImageView.bottomAnchor, trailing: userPhotoImageView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 100))
        
        [userFullName, userAgeLabel, userRegionLabel].forEach {containerView.addSubview($0)}
        userRegionLabel.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 28, right: 0), size: .zero)
        userFullName.anchor(top: nil, leading: userRegionLabel.leadingAnchor, bottom: userRegionLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .zero)

        userAgeLabel.anchor(top: nil, leading: userFullName.trailingAnchor, bottom: userFullName.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .zero)
    }
}
