//
//  MyKnowLanguageView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/19/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class MyKnowLanguageView: BaseUIView {
    
    private let myKnowLanguageLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: MyProfile.Text.knowLanguages.rawValue, fontType: .regular, size: 17)
        return label
    }()
    
    private let myLanguageView: LanguageTagView = {
        let view = LanguageTagView()
        return view
    }()
    private let myKnowLanguagesTagCollection: LanguageCollectionTagView = {
        let view = LanguageCollectionTagView()
        return view
    }()

    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    private func setupLayouts() {
        let stackView = UIStackView(arrangedSubviews: [myLanguageView])
        let separatorView = UIView()
        separatorView.backgroundColor = #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1)
        
        [myKnowLanguageLabel, stackView, myKnowLanguagesTagCollection, separatorView].forEach { addSubview($0) }
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        
        myKnowLanguageLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 30))
        
        stackView.anchor(top: myKnowLanguageLabel.bottomAnchor, leading: myKnowLanguageLabel.leadingAnchor, bottom: nil, trailing: myKnowLanguageLabel.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 30, right: 0), size: .init(width: 0, height: 45))
        
        myKnowLanguagesTagCollection.anchor(top: stackView.bottomAnchor, leading: myKnowLanguageLabel.leadingAnchor, bottom: separatorView.topAnchor, trailing: myKnowLanguageLabel.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 30, right: 0))
        
        separatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 0), size: .init(width: 0, height: 1))
    }
    
    
}


