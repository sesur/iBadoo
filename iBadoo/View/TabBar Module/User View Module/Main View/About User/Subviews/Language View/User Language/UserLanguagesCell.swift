//
//  UserLanguagesCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserLanguagesCell: BaseCell {
    
    var userLanguangeCellObserver: LanguageModel? {
        didSet {
            guard let wrapper = userLanguangeCellObserver else {return}
            knowLabel.attributedText = AttributedStringHelper.getString(text: wrapper.know.rawValue, fontType: .regular, size: 17, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
            language.attributedText = AttributedStringHelper.getString(text: wrapper.spokenLanguages, fontType: .regular, size: 17, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        }
    }
    
    private let knowLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    private let language: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    private let bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorColor
        return view
    }()
    
    //MAKR:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        
//        topSeparatorView,
        
        let stack1 = UIStackView(arrangedSubviews: [knowLabel, language])
        [stack1, bottomSeparatorView].forEach {addSubview($0)}
        
        [stack1].forEach {
            $0.distribution = .fillProportionally
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.spacing = 10
        }
        
        stack1.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 10, left: 20, bottom: 10, right: 0), size: .zero)
        
        bottomSeparatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0.01, right: 0), size: .init(width: 0, height: 1))
    }
}
