//
//  FacebookView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class FacebookView: BaseUIView {
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "facebook"), for: .normal)
        return button
    }()
    private let peopleLikeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: SettingsModel.Text.k.rawValue, fontType: .regular, size: 15, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
        label.sizeToFit()
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        setupLayouts()
    }
    private func setupLayouts() {
        [facebookButton, peopleLikeLabel].forEach {addSubview($0)}
        facebookButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 25, bottom: 0, right: 0), size: .init(width: 85, height: 35))
        
        peopleLikeLabel.anchorCenter(vertical: facebookButton.centerYAnchor, horizontal: nil)
        peopleLikeLabel.anchor(top: nil, leading: facebookButton.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8), size: .zero)
    }
}
