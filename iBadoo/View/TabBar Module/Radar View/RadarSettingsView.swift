//
//  RadarSettingsView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import LTHRadioButton
import DLRadioButton
import RangeSeekSlider

class RadarSettingsView: BaseUIView {
    
    private var chooseAgeRangeStackView = UIStackView()
    private var chooseConnectionStackView = UIStackView()
    private var slideStackView = UIStackView()
    private var connectionStackView = UIStackView()
    private var allPeopleStackview = UIStackView()
    private var girlsStackView = UIStackView()
    private var guysStackView = UIStackView()
    
    //MARK:- Slider
    private lazy var ageSlider: RangeSeekSlider = {
        let slider = RangeSeekSlider(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        slider.delegate = self
        
        slider.minValue = 13
        slider.maxValue = 60
        slider.selectedMinValue = 18
        slider.selectedMaxValue = 24
        slider.colorBetweenHandles = #colorLiteral(red: 0.1303958297, green: 0.2899259031, blue: 0.8916541934, alpha: 1)
        slider.selectedHandleDiameterMultiplier = 1
        slider.handleColor = #colorLiteral(red: 0.1303958297, green: 0.2899259031, blue: 0.8916541934, alpha: 1)
        slider.handleDiameter = 24
        slider.initialColor = #colorLiteral(red: 0.6237031221, green: 0.6837726235, blue: 0.8886747956, alpha: 1)
        slider.lineHeight = 3
        slider.maxLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        slider.minLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
 
        slider.tintColor = #colorLiteral(red: 0.6237031221, green: 0.6837726235, blue: 0.8886747956, alpha: 1)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    //MARK:- ButtomView
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .backGroundLightBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:- Labels
    private let chooseAgeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: RadarSettings.Frame.width.rawValue, height: RadarSettings.Frame.height.rawValue))
        label.attributedText = AttributedStringHelper.getString(text: RadarText.chooseAgeLabel.rawValue, fontType: .regular , size: thirteen, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let connectionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: RadarSettings.Frame.width.rawValue, height: RadarSettings.Frame.height.rawValue))
        label.attributedText = AttributedStringHelper.getString(text: RadarText.connectionLabel.rawValue , fontType: .regular , size: thirteen, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let globalLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: RadarSettings.Frame.width.rawValue, height: RadarSettings.Frame.height.rawValue))
        label.attributedText = AttributedStringHelper.getString(text: RadarText.globalLabel.rawValue, fontType: .regular , size: seventeen, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let localLabel: UILabel = {
        let local = UILabel(frame: CGRect(x: 0, y: 0, width: RadarSettings.Frame.width.rawValue, height: RadarSettings.Frame.height.rawValue))
        local.attributedText = AttributedStringHelper.getString(text:RadarText.localNetwork.rawValue , fontType: .regular , size: seventeen, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        local.translatesAutoresizingMaskIntoConstraints = false
        return local
    }()
    private let allPeopleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: RadarSettings.Frame.width.rawValue, height: RadarSettings.Frame.height.rawValue))
        label.attributedText = AttributedStringHelper.getString(text: RadarText.allPeopleLabel.rawValue , fontType: .regular , size: seventeen, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let girlsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: RadarSettings.Frame.width.rawValue, height: RadarSettings.Frame.height.rawValue))
        label.attributedText = AttributedStringHelper.getString(text: RadarText.girlsLabel.rawValue , fontType: .regular , size: seventeen, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let guysLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: RadarSettings.Frame.width.rawValue, height: RadarSettings.Frame.height.rawValue))
        label.attributedText = AttributedStringHelper.getString(text: RadarText.guysLabel.rawValue, fontType: .regular , size: seventeen, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK:- Buttons
    private lazy var globalButton: DLRadioButton = {
        let global = createConnectionTypeRadioButton(color: .mainBlue)
        global.translatesAutoresizingMaskIntoConstraints = false
        global.isSelected = true
        global.tag = 3
        return global
    }()
    private lazy var localButton: DLRadioButton = {
        let local = createConnectionTypeRadioButton(color: .mainBlue)
        local.translatesAutoresizingMaskIntoConstraints = false
        local.tag = 4
        return local
    }()
    
     private lazy var allPeopleButton: DLRadioButton = {
        let people = createRadioButton( color: .mainBlue)
        people.translatesAutoresizingMaskIntoConstraints = false
        people.tag = 0
        people.isSelected = true
        return people
    }()
    
    private lazy var guysButton: DLRadioButton = {
        let guys = createRadioButton(color: .mainBlue)
        guys.translatesAutoresizingMaskIntoConstraints = false
        guys.tag = 1
        return guys
    }()
    
    private lazy var girlsButton: DLRadioButton = {
        let girls = createRadioButton(color: .mainBlue)
        girls.tag = 2
        girls.translatesAutoresizingMaskIntoConstraints = false
        return girls
    }()
    
    
    //MARK:- Actions
    override func setupViews() {
        super.setupViews()
        backgroundColor = #colorLiteral(red: 0.7782739997, green: 0.8003507257, blue: 0.8648895621, alpha: 1)
        setupAllConstraints()
    }
    
    
    private func setupAllConstraints() {
        setupChooseAgeRangeStackView()
        setupSlideStackView()
        setupConnectionLabelStackView()
        setupConnectionTypeStackView()
        setupAllPeopleStackview()
        setupGirlsStackView()
        setupGuysStackView()
        setupBottomView()
    }
    
    private func createConnectionTypeRadioButton(color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton();
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 20);
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.iconSize = 25
        radioButton.iconStrokeWidth = 1
        radioButton.indicatorSize = 17
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(RadarSettingsView.handleConnectionRaidoButton), for: UIControl.Event.touchUpInside);
        addSubview(radioButton);
        
        return radioButton;
    }
    
    private func createRadioButton(color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton();
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 20);
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.iconSize = 25
        radioButton.iconStrokeWidth = 1
        radioButton.indicatorSize = 17
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(RadarSettingsView.handleShowChoiceButton), for: UIControl.Event.touchUpInside);
        addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc private func handleConnectionRaidoButton(radioButton : DLRadioButton) {
        if radioButton.tag == 3  {
            globalButton.isSelected = true
            localButton.isSelected = false
        } else {
            globalButton.isSelected = false
            localButton.isSelected = true
        }
    }

    @objc private func handleShowChoiceButton(radioButton : DLRadioButton) {
        if radioButton.tag == 0  {
            allPeopleButton.isSelected = true
            guysButton.isSelected = false
            girlsButton.isSelected = false
            
        } else if radioButton.tag == 1 {
            guysButton.isSelected = true
            girlsButton.isSelected = false
            allPeopleButton.isSelected = false
        } else {
            guysButton.isSelected = false
            girlsButton.isSelected = true
            allPeopleButton.isSelected = false
        }
    }
    
    
    private func setupChooseAgeRangeStackView() {
        let ageRangeView = UIView()
        ageRangeView.backgroundColor = .backGroundLightBlue
        
        chooseAgeRangeStackView = UIStackView(arrangedSubviews: [ageRangeView])
        addSubview(chooseAgeRangeStackView)
        chooseAgeRangeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chooseAgeRangeStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            chooseAgeRangeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            chooseAgeRangeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            chooseAgeRangeStackView.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        addSubview(chooseAgeLabel)
        NSLayoutConstraint.activate([
            chooseAgeLabel.centerYAnchor.constraint(equalTo: ageRangeView.centerYAnchor, constant: 0),
            chooseAgeLabel.leadingAnchor.constraint(equalTo: ageRangeView.leadingAnchor, constant: 16)
            ])
    }
    
    private func setupSlideStackView(){
        let slideView = UIView()
        slideView.backgroundColor = .backGroundLightBlue
        
        slideStackView = UIStackView(arrangedSubviews: [slideView])
        addSubview(slideStackView)
        
        slideStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slideStackView.topAnchor.constraint(equalTo: chooseAgeRangeStackView.bottomAnchor, constant: 0),
            slideStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            slideStackView.heightAnchor.constraint(equalToConstant: 70),
            slideStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            ])
        
        addSubview(ageSlider)
        NSLayoutConstraint.activate([
            ageSlider.centerYAnchor.constraint(equalTo: slideView.centerYAnchor, constant: 0),
            ageSlider.heightAnchor.constraint(equalToConstant: 30),
            ageSlider.leadingAnchor.constraint(equalTo: slideView.leadingAnchor, constant: 16),
            ageSlider.trailingAnchor.constraint(equalTo: slideView.trailingAnchor, constant: -16),
            ])
    }
    
    private func setupConnectionLabelStackView() {
        let connectionView = UIView()
        connectionView.backgroundColor = .backGroundLightBlue
        
        chooseConnectionStackView = UIStackView(arrangedSubviews: [connectionView])
        addSubview(chooseConnectionStackView)
        chooseConnectionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chooseConnectionStackView.topAnchor.constraint(equalTo: slideStackView.bottomAnchor, constant: 0),
            chooseConnectionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            chooseConnectionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            chooseConnectionStackView.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        addSubview(connectionLabel)
        NSLayoutConstraint.activate([
            connectionLabel.centerYAnchor.constraint(equalTo: connectionView.centerYAnchor, constant: 0),
            connectionLabel.leadingAnchor.constraint(equalTo: connectionView.leadingAnchor, constant: 16)
            ])
    }
    
    private func setupConnectionTypeStackView(){
        let globalView = UIView()
        globalView.backgroundColor = #colorLiteral(red: 0.9084959626, green: 0.9218084216, blue: 0.9621023536, alpha: 1)
        
        let localView = UIView()
        localView.backgroundColor = #colorLiteral(red: 0.9084959626, green: 0.9218084216, blue: 0.9621023536, alpha: 1)
        connectionStackView = UIStackView(arrangedSubviews: [globalView, localView])
        addSubview(connectionStackView)
        
        connectionStackView.translatesAutoresizingMaskIntoConstraints = false
        connectionStackView.axis = .horizontal
        connectionStackView.alignment = .fill
        connectionStackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            connectionStackView.topAnchor.constraint(equalTo: chooseConnectionStackView.bottomAnchor, constant: 1),
            connectionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            connectionStackView.heightAnchor.constraint(equalToConstant: 60),
            connectionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            ])
        
        
        addSubview(globalButton)
        NSLayoutConstraint.activate([
            globalButton.centerYAnchor.constraint(equalTo: globalView.centerYAnchor, constant: 0), // -(radioButtonDiameter/2)
            globalButton.leadingAnchor.constraint(equalTo: globalView.leadingAnchor, constant: 16)
            ])
        
        addSubview(localButton)
        NSLayoutConstraint.activate([
            localButton.centerYAnchor.constraint(equalTo: localView.centerYAnchor, constant: 0), // -(radioButtonDiameter/2)
            localButton.leadingAnchor.constraint(equalTo: localView.leadingAnchor, constant: 16)
            ])
        addSubview(globalLabel)
        NSLayoutConstraint.activate([
            globalLabel.centerYAnchor.constraint(equalTo: globalView.centerYAnchor),
            globalLabel.leadingAnchor.constraint(equalTo: globalButton.trailingAnchor, constant: 15)
            ])
        addSubview(localLabel)
        NSLayoutConstraint.activate([
            localLabel.centerYAnchor.constraint(equalTo: localView.centerYAnchor),
            localLabel.leadingAnchor.constraint(equalTo: localButton.trailingAnchor, constant: 15)
            ])
    }
    
    private func setupAllPeopleStackview(){
        let allPeopleView = UIView()
        allPeopleView.backgroundColor = .backGroundLightBlue
        
        allPeopleStackview = UIStackView(arrangedSubviews: [allPeopleView])
        addSubview(allPeopleStackview)
        allPeopleStackview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allPeopleStackview.topAnchor.constraint(equalTo: connectionStackView.bottomAnchor, constant: 1),
            allPeopleStackview.leadingAnchor.constraint(equalTo: connectionStackView.leadingAnchor),
            allPeopleStackview.heightAnchor.constraint(equalToConstant: 69),
            allPeopleStackview.trailingAnchor.constraint(equalTo: connectionStackView.trailingAnchor)
            ])
        addSubview(allPeopleButton)
        NSLayoutConstraint.activate([
            allPeopleButton.centerYAnchor.constraint(equalTo: allPeopleView.centerYAnchor, constant: 0), // -(radioButtonDiameter/2)
            allPeopleButton.leadingAnchor.constraint(equalTo: globalButton.leadingAnchor)
            ])
        addSubview(allPeopleLabel)
        NSLayoutConstraint.activate([
            allPeopleLabel.centerYAnchor.constraint(equalTo: allPeopleView.centerYAnchor),
            allPeopleLabel.leadingAnchor.constraint(equalTo: globalLabel.leadingAnchor)
            ])
    }
    
    private func setupGirlsStackView(){
        addSubview(girlsButton) // added
        
        let girlsView = UIView()
        girlsView.backgroundColor = .backGroundLightBlue
        
        girlsStackView = UIStackView(arrangedSubviews: [girlsView])
        addSubview(girlsStackView)
        girlsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            girlsStackView.topAnchor.constraint(equalTo: allPeopleStackview.bottomAnchor, constant: 1),
            girlsStackView.leadingAnchor.constraint(equalTo: connectionStackView.leadingAnchor),
            girlsStackView.heightAnchor.constraint(equalToConstant: 69),
            girlsStackView.trailingAnchor.constraint(equalTo: connectionStackView.trailingAnchor)
            ])
        addSubview(girlsButton)
        NSLayoutConstraint.activate([
            girlsButton.centerYAnchor.constraint(equalTo: girlsView.centerYAnchor, constant: 0), //  -(radioButtonDiameter/2)
            girlsButton.leadingAnchor.constraint(equalTo: globalButton.leadingAnchor)
            ])
        addSubview(girlsLabel)
        NSLayoutConstraint.activate([
            girlsLabel.centerYAnchor.constraint(equalTo: girlsView.centerYAnchor),
            girlsLabel.leadingAnchor.constraint(equalTo: globalLabel.leadingAnchor)
            ])
        
    }
    
    private func setupGuysStackView(){
        let guysView = UIView()
        guysView.backgroundColor = .backGroundLightBlue
        
        guysStackView = UIStackView(arrangedSubviews: [guysView])
        addSubview(guysStackView)
        guysStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            guysStackView.topAnchor.constraint(equalTo: girlsStackView.bottomAnchor, constant: 1),
            guysStackView.leadingAnchor.constraint(equalTo: connectionStackView.leadingAnchor),
            guysStackView.heightAnchor.constraint(equalToConstant: 69),
            guysStackView.trailingAnchor.constraint(equalTo: connectionStackView.trailingAnchor)
            ])
        addSubview(guysButton)
        NSLayoutConstraint.activate([
            guysButton.leadingAnchor.constraint(equalTo: globalButton.leadingAnchor),
            guysButton.centerYAnchor.constraint(equalTo: guysView.centerYAnchor, constant: 0), // -(radioButtonDiameter/2)
            ])
        addSubview(guysLabel)
        NSLayoutConstraint.activate([
            guysLabel.topAnchor.constraint(equalTo: guysButton.topAnchor),
            guysLabel.leadingAnchor.constraint(equalTo: globalLabel.leadingAnchor)
            ])
    }
    
    private func setupBottomView() {
        addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: guysStackView.bottomAnchor, constant: 1),
            bottomView.leadingAnchor.constraint(equalTo: guysStackView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: guysStackView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            
            ])
    }
}



extension RadarSettingsView: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider == ageSlider {
            print("Slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}





























