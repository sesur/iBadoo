//
//  TermsAndConditionsView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class TermsAndConditionsView: BaseUIView {
    
    private let termsAndConditionsTextView: UITextView = {
        let text = UITextView()
        text.isScrollEnabled = false
        text.attributedText = AttributedStringHelper.getStringNoneColor(text: Settings.Text.termsAndConditions.rawValue, fontType: .regular, size: 17)
        text.scrollRangeToVisible(NSRange(location: 0, length: 0))
        text.isEditable = false
        text.textContainerInset = UIEdgeInsets.init(top: 30, left: 10, bottom: 0, right: 10)
        text.isScrollEnabled = true
        text.scrollsToTop = true
        return text
    }()
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        setupLayouts()
    }
    private func setupLayouts() {
        addSubview(termsAndConditionsTextView)
        termsAndConditionsTextView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 70, left: 0, bottom: 0, right: 0), size: .zero)
    }
}
