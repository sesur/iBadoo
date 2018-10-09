//
//  MyProfileCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/16/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class MyProfileCell: BaseCell {
    
    var myProfileCellObserver: MyProfileModel? {
        didSet {
            guard let wrapper = myProfileCellObserver else {return}
            settingsLabel.attributedText = AttributedStringHelper.getStringNoneColor(text: wrapper.nameLabel.rawValue, fontType: .regular, size: 17)
            arrowImageView.image = UIImage(named: wrapper.imageName)?.withRenderingMode(.alwaysTemplate)
            arrowImageView.tintColor = .black
        }
    }
    
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
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
        backgroundColor = #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
        setupLayout()
    }
//    override var isHighlighted: Bool {
//        didSet {
//            backgroundColor = isHighlighted ? .biggerCircleBlue : #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
//            settingsLabel.textColor = isHighlighted ? .white : .black
//            arrowImageView.tintColor = isHighlighted ? .white : .mainBlue
//            topSeparatorView.backgroundColor = isHighlighted ? .biggerCircleBlue : .separatorColor
//        }
//    }
//    override var isSelected: Bool {
//        didSet {
//            backgroundColor = isSelected ? .biggerCircleBlue : #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
//            settingsLabel.textColor = isSelected ? .white : .black
//            arrowImageView.tintColor = isSelected ? .bgLightBlue : .mainBlue
//            topSeparatorView.backgroundColor = isSelected ? .biggerCircleBlue : .separatorColor
//        }
//    }
    
    
    //MARK:- Layouts
    private func setupLayout() {
//        let topSepparatorView = UIView()
//        topSepparatorView.backgroundColor = .separatorColor
        
        [settingsLabel, arrowImageView, topSeparatorView].forEach { addSubview($0)}
        settingsLabel.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        settingsLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 25, bottom: 0, right: 0), size: .zero)
        
        arrowImageView.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        arrowImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 21), size: .init(width: 10, height: 16))
        
        topSeparatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 1, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
    }
    
    
    
}
