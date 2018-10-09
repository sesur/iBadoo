//
//  UserInfoCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
// FeedCell

class UserInfoCell: BaseCell {

    private let userInterestView: UserInterestsView = {
        let view = UserInterestsView()
        return view
    }()
    lazy var userVisitedCountriesView: UserVisitedCountriesView = {
        let view = UserVisitedCountriesView()
        return view
    }()
    private let userRelashionshipView: UserRelashionshipView = {
        let view = UserRelashionshipView()
        return view
    }()
    private let userLanguageView: UserLanguagePreView = {
        let view = UserLanguagePreView()
        return view
    }()
    
    private let showAllTripsButton: UIButton = {
        let button = UIButton()
        let customAttributtedText = AttributedStringHelper.getString(text: MyProfile.Text.showAllTrips.rawValue, fontType: .regular, size: 15, color: .mainBlue)
        button.setAttributedTitle(customAttributtedText, for: .normal)
        button.addTarget(nil, action: #selector(UserProfileViewController.handleShowCountriesButtonTap(sender:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLauyouts()
    }
    
    //MARK:- Layouts
    private func setupLauyouts() {
        [userInterestView, userVisitedCountriesView, showAllTripsButton, userRelashionshipView, userLanguageView] .forEach {addSubview($0)}
        userInterestView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 100))
        
        userVisitedCountriesView.anchor(top: userInterestView.bottomAnchor, leading: userInterestView.leadingAnchor, bottom: nil, trailing: userInterestView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 300))
        
        showAllTripsButton.anchor(top: userVisitedCountriesView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 50))

        userRelashionshipView.anchor(top: showAllTripsButton.bottomAnchor, leading: userInterestView.leadingAnchor, bottom: nil, trailing: userInterestView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 105))
        
        userLanguageView.anchor(top: userRelashionshipView.bottomAnchor, leading: userInterestView.leadingAnchor, bottom: nil, trailing: userInterestView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 250))
    }
}
