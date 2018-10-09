//
//  ProfileMenuCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/26/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class ProfileMenuCell: BaseCell {
    
    var menuCellObserver: MenuBarModel? {
        didSet {
            guard let unwrappedMenuCell = menuCellObserver else { return }
            imageView.image = UIImage(named: unwrappedMenuCell.imageName)?.withRenderingMode(.alwaysTemplate)
            let formattedText = AttributedStringHelper.getStringNoneColor(text: unwrappedMenuCell.nameLabel.rawValue, fontType: .regular, size: 15)
            cellLabel.attributedText = formattedText
        }
    }
    
    private let imageView: UIImageView = {
        let imv = UIImageView()
        imv.tintColor = .lightGray
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.sizeToFit()
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ?  .mainBlue : .lightGray
            cellLabel.textColor = isHighlighted ? .mainBlue : .lightGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .mainBlue : .lightGray
            cellLabel.textColor = isSelected ? .mainBlue : .lightGray
        }
    }
    
    override func setupViews() {
        setupLayouts()
        backgroundColor = .white
    }
    
    private func setupLayouts() {
        let stack = UIStackView(arrangedSubviews: [imageView, cellLabel])
        [stack].forEach {addSubview($0)}
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 15
        
        stack.anchorCenter(vertical: centerYAnchor, horizontal: centerXAnchor)
        stack.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .zero, size: .init(width: 0, height: 24))
        
//
//        [imageView, cellLabel].forEach { $0.anchorCenter(vertical: nil, horizontal: centerXAnchor) }
//
//        imageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 18, left: 0, bottom: 0, right: 0), size: .init(width: 24, height: 24))
//
//        cellLabel.anchor(top: imageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 9, left: 0, bottom: 0, right: 0), size: .zero)
    }
}

