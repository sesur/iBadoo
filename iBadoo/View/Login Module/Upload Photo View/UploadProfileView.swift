//
//  UploadProfileView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 3/6/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UploadProfileView: BaseUIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.2860870957, blue: 0.9036547542, alpha: 1)
        return view
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let bottomMessageLabel: UILabel = {
        let label = UILabel()
        let customAttributtedString = AttributedStringHelper.getString(text: Camera.bottomMessTitle.rawValue, fontType: .regular, size: 28, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        customAttributtedString.append(AttributedStringHelper.getString(text: Camera.bottomMessSubtitle.rawValue, fontType: .regular, size: 17, color: .lightGray))
        label.attributedText = customAttributtedString
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    private func setupLayouts(){
        [customView, bottomMessageLabel].forEach {addSubview($0)}
        [separatorView].forEach {customView.addSubview($0)}

        customView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: UIScreen.main.bounds.height / 2))
        
        separatorView.anchor(top: customView.topAnchor, leading: nil, bottom: customView.bottomAnchor, trailing: nil, padding: .init(top: 80, left: 0, bottom: 75, right: 0), size: .init(width: 2, height: 0))
        separatorView.anchorCenter(vertical: nil, horizontal: customView.centerXAnchor)
        
        bottomMessageLabel.anchor(top: customView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 70, left: 72, bottom: 0, right: 72), size: .zero)
    }
}
