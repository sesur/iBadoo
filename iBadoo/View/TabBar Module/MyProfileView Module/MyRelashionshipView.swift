//
//  MyRelashionshipView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/19/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import DropDown

class MyRelashionshipView: BaseUIView {
    
    private let myRelashionshipLabel: UILabel = {
        let label = UILabel()
        label.attributedText = AttributedStringHelper.getStringNoneColor(text: MyProfile.Text.relashionship.rawValue, fontType: .regular, size: 17)
        return label
    }()
    
    private lazy var chooseTypeDropDown: DropDown = {
        let drop = DropDown()
        return drop
    }()
    
    private lazy var dropDowns: [DropDown] = {
        return [ self.chooseTypeDropDown
        ]
    }()
    
    private lazy var myRelashionshipTypeTextField: CustomTextField = {
        let text = CustomTextField()
        text.placeholder = MyProfile.Text.relashionshipPlaceholder.rawValue
        text.applyDropDownButton(image: UIImage(named: "arrow down")!)
        text.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        text.delegate = self
        text.autocapitalizationType = .none
        return text
    }()
    private lazy var myPartnerTextField: CustomTextField = {
        let text = CustomTextField()
        text.placeholder = MyProfile.Text.withPlaceholder.rawValue
        text.applyCustomClearButton(image: UIImage(named: "cancel")!)
        text.addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        text.delegate = self
        text.autocapitalizationType = .none
        return text
    }()
    
    override func setupViews() {
        super.setupViews()
        setupLayouts()
        
        setupDropDowns()
    }
    
    private func setupDropDowns() {
        DispatchQueue.main.async {
            self.chooseTypeDropDown.anchorView = self.myRelashionshipTypeTextField
            self.chooseTypeDropDown.bottomOffset = CGPoint(x: 0, y: self.myRelashionshipTypeTextField.bounds.height)
        } // Bug - resets is defaults position, hides the element
        
        DropDown.appearance().backgroundColor = .white
        chooseTypeDropDown.selectionBackgroundColor = .backGroundLightBlue
        chooseTypeDropDown.shadowOpacity = 0.3
        chooseTypeDropDown.shadowColor = .biggerCircleBlue
        chooseTypeDropDown.dataSource = [
            "Single",
            "Married",
            "Divorced",
            "Separated",
            "Engaged",
            "Civil union"
        ]
        
        // Action triggered on selection
        chooseTypeDropDown.selectionAction = { [weak self] (index, item) in
            self?.myRelashionshipTypeTextField.text = item
        }
        
    }

    private func setupLayouts() {
        let stackView = UIStackView(arrangedSubviews: [myRelashionshipTypeTextField, myPartnerTextField])
        let separatorView = UIView()
        separatorView.backgroundColor = #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1)
        
        [myRelashionshipLabel, stackView, separatorView, chooseTypeDropDown].forEach { addSubview($0)}
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        
        
        myRelashionshipLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 30))
        
        chooseTypeDropDown.anchor(top: myRelashionshipTypeTextField.bottomAnchor, leading: myRelashionshipTypeTextField.leadingAnchor, bottom: nil, trailing: myRelashionshipTypeTextField.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .zero)
        
        stackView.anchor(top: myRelashionshipLabel.bottomAnchor, leading: myRelashionshipLabel.leadingAnchor, bottom: separatorView.topAnchor, trailing: myRelashionshipLabel.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 30, right: 0))
   
        separatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 0), size: .init(width: 0, height: 1))
    }
}

extension MyRelashionshipView: UITextFieldDelegate  {
    
    //MARK:- TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == myRelashionshipTypeTextField {
            myRelashionshipTypeTextField.text = nil
            chooseTypeDropDown.show()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == myRelashionshipTypeTextField {
            chooseTypeDropDown.hide()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == myRelashionshipTypeTextField {
            chooseTypeDropDown.show()
            return false
        }
        return true
    }
    
}
