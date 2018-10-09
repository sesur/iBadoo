//
//  AppVersionView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class AppVersionView: BaseUIView {
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: Settings.Text.version.rawValue, fontType: .regular, size: 20)
        label.sizeToFit()
        return label
    }()
   
    private let availableLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: Settings.Text.availability.rawValue, fontType: .regular, size: 15, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    private let updateMessageLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: Settings.Text.updateMessage.rawValue, fontType: .regular, size: 20)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let updateButton: CustomButton = {
        let button = CustomButton()
        let customAttributtedText = AttributedStringHelper.getString(text: Settings.Text.update.rawValue, fontType: .regular, size: 17, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        button.backgroundColor = .mainBlue
        button.setAttributedTitle(customAttributtedText, for: .normal)
        return button
    }()
    private let copyRightLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getString(text: Settings.Text.copyright.rawValue, fontType: .regular, size: 15, color: #colorLiteral(red: 0.4647983909, green: 0.533918798, blue: 0.6709648967, alpha: 1))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        setupLayouts()
    }
    private func setupLayouts() {
        [versionLabel, availableLabel, updateMessageLabel, updateButton, copyRightLabel].forEach {addSubview($0)}
        [versionLabel, availableLabel, updateMessageLabel, updateButton, copyRightLabel].forEach {
            $0.anchorCenter(vertical: nil, horizontal: centerXAnchor)
        }
        versionLabel.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 110, left: 0, bottom: 0, right: 0), size: .zero)
        
        availableLabel.anchor(top: versionLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .zero)
        
        updateMessageLabel.anchor(top: availableLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 46, left: 0, bottom: 0, right: 0), size: .zero)
        
        updateButton.anchor(top: nil, leading: nil, bottom: copyRightLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 98, right: 0), size: .init(width: 240, height: 48))
        
        copyRightLabel.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 30, right: 0), size: .zero)
    }
}
