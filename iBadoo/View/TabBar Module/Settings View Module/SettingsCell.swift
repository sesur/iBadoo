//
//  SettingsCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/21/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    var settingsCellObserver: SettingsModel? {
        didSet {
            guard let wrapper = settingsCellObserver else {return}
            settingsLabel.attributedText = AttributedStringHelper.getStringNoneColor(text: wrapper.nameLabel.rawValue, fontType: .regular, size: 17)
            arrowImageView.image = UIImage(named: wrapper.imageName)?.withRenderingMode(.alwaysTemplate)
            arrowImageView.tintColor = .black
            if let subtitle = wrapper.subtitle?.rawValue {
                subtitleLabel.attributedText = AttributedStringHelper.getString(text: subtitle, fontType: .regular, size: 15, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
            }
        }
    }
    
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    private let subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.sizeToFit()
        return subtitle
    }()
    private let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorColor
        return view
    }()
    
    //MAKR:- Life Cycle
    override func setupViews() {
        super.setupViews()
//        backgroundColor = #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        
        let stack = UIStackView(arrangedSubviews: [settingsLabel, subtitleLabel])
        [arrowImageView,stack, topSeparatorView].forEach {addSubview($0)}
     
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.alignment = .top
        
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: arrowImageView.leadingAnchor, padding: .init(top: 12, left: 25, bottom: 12, right: 5), size: .zero)
        
        arrowImageView.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        arrowImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 21), size: .init(width: 10, height: 16))
        
        topSeparatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0.01, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
    }
    
    
    
}
