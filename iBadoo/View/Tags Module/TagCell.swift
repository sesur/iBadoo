//
//  TagCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/2/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class TagCell: BaseCell, BorderProtocol, RoundCornerProtocol{
    
    var collectionTagObserver: Tags? {
        didSet {
            guard let unwrappedCollcetion = collectionTagObserver else { return }
            bodyText.attributedText = AttributedStringHelper.getString(text: unwrappedCollcetion.textName!, fontType: .regular, size: 15, color:  #colorLiteral(red: 0, green: 0.2860870957, blue: 0.9036547542, alpha: 1))
        }
    }
    
    private let bodyText: CustomTextView = {
        let text = CustomTextView()
        text.backgroundColor = .clear
        text.isEditable = false
        text.isScrollEnabled = false
        text.alwaysBounceHorizontal = true
        return text
    }()
    
    private let bubleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func setupViews() {
        setupLayouts()
        addBorder(color: #colorLiteral(red: 0, green: 0.2860870957, blue: 0.9036547542, alpha: 1))
        addBorder(width: 1)
        addRoundCorner()
    }
    private func setupLayouts() {
        [bubleView, bodyText].forEach{addSubview($0)}
        bubleView.fillSuperView()
        bodyText.fillSuperView()
    }
}
