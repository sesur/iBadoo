//
//  VisitedCountriesView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserVisitedCountriesView: BaseUIView {
    
    private let visitedLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: MyProfile.Text.visitedCountries.rawValue, fontType: .regular, size: 17)
        label.sizeToFit()
        return label
    }()
//    private let showAllTripsButton: UIButton = {
//        let button = UIButton()
//        let customAttributtedText = AttributedStringHelper.getString(text: MyProfile.Text.showAllTrips.rawValue, fontType: .regular, size: 15, color: .mainBlue)
//        button.setAttributedTitle(customAttributtedText, for: .normal)
//        button.addTarget(nil, action: #selector(UserProfileViewController.handleShowCountriesButtonTap(sender:)), for: .touchUpInside)
//        return button
//    }()
    private let countryView: UserCountriesPreView = {
        let view = UserCountriesPreView()
        return view
    }()
    
    //MARK: Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
//        showAllTripsButton,
        [visitedLabel, countryView].forEach { addSubview($0) }
        visitedLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 30))
        
//        showAllTripsButton.anchor(top: nil, leading: nil, bottom: visitedLabel.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20), size: .init(width: 0, height: 30))
        
        countryView.anchor(top: visitedLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
}

