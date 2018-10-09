//
//  MenuCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/12/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    var menuCellObserver: MenuBarModel? {
        didSet {
            guard let unwrappedMenuCell = menuCellObserver else { return }
            imageView.image = UIImage(named: unwrappedMenuCell.imageName)?.withRenderingMode(.alwaysTemplate)
            cellLabel.attributedText = AttributedStringHelper.getStringNoneColor(text: unwrappedMenuCell.nameLabel.rawValue, fontType: .regular, size: 20)
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = #colorLiteral(red: 0.3487198353, green: 0.4947527647, blue: 0.9329457879, alpha: 1)
        return imageView
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.3487198353, green: 0.4947527647, blue: 0.9329457879, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .white : #colorLiteral(red: 0.3487198353, green: 0.4947527647, blue: 0.9329457879, alpha: 1)
            cellLabel.textColor = isHighlighted ? .white : #colorLiteral(red: 0.3487198353, green: 0.4947527647, blue: 0.9329457879, alpha: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : #colorLiteral(red: 0.3487198353, green: 0.4947527647, blue: 0.9329457879, alpha: 1)
            cellLabel.textColor = isSelected ? .white : #colorLiteral(red: 0.3487198353, green: 0.4947527647, blue: 0.9329457879, alpha: 1)
        }
    }
    
    override func setupViews() {
        setupLayouts()
    }
    
    private func setupLayouts() {
        [imageView, cellLabel].forEach {addSubview($0)}
        imageView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 54, bottom: 20, right: 0), size: .init(width: 30, height: 25))
        
        cellLabel.anchor(top: nil, leading: imageView.trailingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 18, bottom: 20, right: 0), size: .init(width: 70, height: 25))
    }
}



















