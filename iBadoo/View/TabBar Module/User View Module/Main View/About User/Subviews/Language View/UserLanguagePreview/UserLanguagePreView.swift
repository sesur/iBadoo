//
//  UserLanguagePreView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserLanguagePreView: BaseUIView {
    
    private let userKnowLanguageLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: MyProfile.Text.knowLanguages.rawValue, fontType: .regular, size: 17)
        label.sizeToFit()
        return label
    }()

    private let userlanguageView: UserLanguageView = {
        let view = UserLanguageView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [userKnowLanguageLabel, userlanguageView].forEach { addSubview($0) }
        userKnowLanguageLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 30))
        
        userlanguageView.anchor(top: userKnowLanguageLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
   
}

