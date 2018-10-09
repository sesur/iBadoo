//
//  InterestsView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/19/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class MyInterestsView: BaseUIView {
    
    private let myInterestsLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: MyProfile.Text.interests.rawValue, fontType: .regular, size: 17)
        return label
    }()
    
    private let myHobbyView: HobbiesTagView = {
        let view = HobbiesTagView()
        return view
    }()
    private let myHobbiesTagCollection: HobbiesCollectionTagView = {
        let view = HobbiesCollectionTagView()
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    private func setupLayouts() {
        let stackView = UIStackView(arrangedSubviews: [myHobbyView])
        
        [myInterestsLabel, stackView, myHobbiesTagCollection].forEach { addSubview($0) }
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        
        myInterestsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 30))
        
        stackView.anchor(top: myInterestsLabel.bottomAnchor, leading: myInterestsLabel.leadingAnchor, bottom: nil, trailing: myInterestsLabel.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 30, right: 0), size: .init(width: 0, height: 45))
        
        myHobbiesTagCollection.anchor(top: stackView.bottomAnchor, leading: myInterestsLabel.leadingAnchor, bottom: bottomAnchor, trailing: myInterestsLabel.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 0), size: .init(width: 0, height: 0))
    }
}

