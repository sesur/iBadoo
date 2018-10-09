//
//  RadioButtonsView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import LTHRadioButton

class RadioButtonsView: BaseUIView {
    private let maleRadioButton: LTHRadioButton = {
        let button = LTHRadioButton(diameter: 25, selectedColor: .mainBlue, deselectedColor: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        button.select()
        return button
    }()
    private let femaleRadioButton: LTHRadioButton = {
        let button = LTHRadioButton(diameter: 25, selectedColor: .mainBlue, deselectedColor: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        return button
    }()
    private let maleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Male", fontType: .regular, size: 17, color: #colorLiteral(red: 0.1411608458, green: 0.1411868036, blue: 0.1411526501, alpha: 1))
        label.sizeToFit()
        return label
    }()
    private let femaleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: "Female", fontType: .regular, size: 17, color: #colorLiteral(red: 0.1411608458, green: 0.1411868036, blue: 0.1411526501, alpha: 1))
        label.sizeToFit()
        return label
    }()
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    private func setupLayouts() {
        let maleStack = UIStackView(arrangedSubviews: [maleRadioButton, maleLabel])
        let femaleStack = UIStackView(arrangedSubviews: [femaleRadioButton, femaleLabel])
        
        [maleStack, femaleStack].forEach {addSubview($0)}
        [maleStack, femaleStack].forEach { (stack) in
            stack.axis = .horizontal
            stack.distribution = .fillProportionally
            stack.alignment = .fill
            stack.spacing = 50
        }
        maleStack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 35, bottom: 0, right: 0), size: .zero)
        maleStack.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        
        femaleStack.anchorSize(to: maleStack)
        femaleStack.anchor(top: maleStack.topAnchor, leading: maleStack.trailingAnchor, bottom: maleStack.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 35, bottom: 0, right: 25), size: .zero)
    }
}

