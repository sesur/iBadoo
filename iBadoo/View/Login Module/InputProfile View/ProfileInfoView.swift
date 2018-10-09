//
//  ProfileInfoView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/17/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import LTHRadioButton
//import WSTagsField
import TagListView

class ProfileInfoView: BaseUIView {
    
    private lazy var userFormView: UserFormView = {
        let view = UserFormView()
        return view
    }()
    private lazy var maleFemaleRadioButtonsView: RadioButtonsView = {
        let view = RadioButtonsView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }

    //MARK:- Tags
    private let languageKnowTextField: LanguageTagView = {
        let language = LanguageTagView()
        return language
    }()
    private let languageTagCollection: LanguageCollectionTagView = {
        let hobby = LanguageCollectionTagView()
        return hobby
    }()
    private let hobbyTextFieldView: HobbiesTagView = {
        let view = HobbiesTagView()
        return view
    }()
    private let hobbyTagstCollection: HobbyTagsCollection = {
        let tag = HobbyTagsCollection()
        return tag
    }()
    
    //MARK:- Layouts

    private func setupLayouts() {
        [userFormView, maleFemaleRadioButtonsView, languageKnowTextField, languageTagCollection, hobbyTextFieldView, hobbyTagstCollection].forEach {addSubview($0)}
        userFormView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 237))

        maleFemaleRadioButtonsView.anchor(top: userFormView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 90))
        
         languageKnowTextField.anchor(top: maleFemaleRadioButtonsView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 15, left: 35, bottom: 0, right: 35), size: .init(width: 0, height: 54))
        
        languageTagCollection.anchor(top: languageKnowTextField.bottomAnchor, leading: languageKnowTextField.leadingAnchor, bottom: nil, trailing: languageKnowTextField.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 90))
        
        hobbyTextFieldView.anchor(top: languageTagCollection.bottomAnchor, leading: languageKnowTextField.leadingAnchor, bottom: nil, trailing: languageKnowTextField.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 54))
        
        hobbyTagstCollection.anchor(top: topAnchor, leading: languageKnowTextField.leadingAnchor, bottom: bottomAnchor, trailing: languageKnowTextField.trailingAnchor, padding: .init(top: 585, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 300)) // other important feature for ScrollView
    }
}

extension ProfileInfoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
