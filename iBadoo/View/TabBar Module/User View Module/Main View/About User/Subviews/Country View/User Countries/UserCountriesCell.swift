//
//  UserCountriesCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserCountriesCell: BaseCell {
    
    var countriesCellObserver: CountryModel? {
        didSet {
            guard let wrapper = countriesCellObserver else {return}
            wasInLabel.attributedText = AttributedStringHelper.getString(text: wrapper.wasIn.rawValue, fontType: .regular, size: 17, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
            userLocationLabel.attributedText = AttributedStringHelper.getString(text: wrapper.locationsVizited, fontType: .regular, size: 17, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            
            timeIconImageView.image = UIImage(named: wrapper.iconName)?.withRenderingMode(.alwaysTemplate)
            timeIconImageView.tintColor = .lightGray
            
            dateLabel.attributedText = AttributedStringHelper.getString(text: wrapper.date, fontType: .regular, size: 17, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
        }
    }
    
    private let wasInLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    private let userLocationLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    private let dateLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.sizeToFit()
        return subtitle
    }()
    private let timeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
//    private let topSeparatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .separatorColor
//        return view
//    }()
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
        let stack1 = UIStackView(arrangedSubviews: [wasInLabel, userLocationLabel])
        let stack2 = UIStackView(arrangedSubviews: [timeIconImageView, dateLabel])
        [stack1, stack2, bottomSeparatorView].forEach {addSubview($0)}
    
        [stack1, stack2].forEach {
            $0.distribution = .fillProportionally
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.spacing = 10
        }
        stack1.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0), size:.init(width: 0, height: 30) )
        
        stack2.anchor(top: nil, leading: leadingAnchor, bottom: bottomSeparatorView.topAnchor, trailing: nil, padding:.init(top: 0, left: 20, bottom: 10, right: 0), size: .init(width: 0, height: 30))
    
         bottomSeparatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 1))
    }
    
    
}
