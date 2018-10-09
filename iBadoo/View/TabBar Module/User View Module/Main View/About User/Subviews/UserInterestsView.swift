//
//  UserInterestsView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserInterestsView: BaseUIView {
    
    private let interestsLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: MyProfile.Text.interests.rawValue, fontType: .regular, size: 17)
        return label
    }()
    private let hobbiesTagCollection: HobbiesCollectionTagView = {
        let view = HobbiesCollectionTagView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [interestsLabel, hobbiesTagCollection].forEach { addSubview($0) }
        interestsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 30))
        
        hobbiesTagCollection.anchor(top: interestsLabel.bottomAnchor, leading: interestsLabel.leadingAnchor, bottom: bottomAnchor, trailing: interestsLabel.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 15, right: 0), size: .init(width: 0, height: 0))
    }
}
