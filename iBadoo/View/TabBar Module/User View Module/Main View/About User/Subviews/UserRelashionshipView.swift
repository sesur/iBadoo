//
//  UserRelashionshipView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserRelashionshipView: BaseUIView {
    
    private let relashionshipLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: MyProfile.Text.relashionship.rawValue, fontType: .regular, size: 17)
        label.sizeToFit()
        return label
    }()
    private let inRelashionshipWithLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: MyProfile.Text.inRelashionshipWith.rawValue, fontType: .regular, size: 17, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
        label.sizeToFit()
        return label
    }()
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: "Hariton Margareta", fontType: .regular, size: 17)
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()

    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [relashionshipLabel, inRelashionshipWithLabel, fullNameLabel].forEach { addSubview($0) }
        relashionshipLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 30))
        
        inRelashionshipWithLabel.anchor(top: relashionshipLabel.bottomAnchor, leading: relashionshipLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .zero)
        
        fullNameLabel.anchor(top: nil, leading: inRelashionshipWithLabel.trailingAnchor, bottom: inRelashionshipWithLabel.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 25, bottom: 0, right: 0), size: .zero)
    }
}
