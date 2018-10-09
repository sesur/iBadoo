//
//  DefaultRadarView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/29/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class DefaultRadarView: BaseUIView {
    
    private let imageWidth: CGFloat = 140
    private let heightDistance: CGFloat = 70
    private let labelWidth: CGFloat = 298
    //circles
    private let bigCircleRadius: CGFloat = 160
    private let midleCircleRadius: CGFloat = 130
    private let smallCircleRadius: CGFloat = 100
    
    
    var userObserver: CurrentUser? {
        didSet {
            guard let unwrappedCurrentUser = userObserver else { return }
            guard let fullName = unwrappedCurrentUser.fullName else {return}
            bottomLabelMesage.attributedText = AttributedStringHelper.getString(text: fullName, fontType: .regular, size: 24, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            profileImageView.loadImageUsingCacheWith(unwrappedCurrentUser.profilePictureUrl)
        }
    }
    
   lazy var profileImageView: UIImageView = {

        let imageView = UIImageView()
//        imageView.image = UIImage(named: DefaultRadar.Image.name.rawValue)
        imageView.layer.cornerRadius  = imageWidth / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var bottomLabelMesage: UILabel = {
        let message = UILabel()
        message.attributedText = AttributedStringHelper.getString(text: DefaultRadar.Label.message
            .rawValue, fontType: .regular, size: 22, color: #colorLiteral(red: 0.513635993, green: 0.5458706021, blue: 0.6625539064, alpha: 1))
        message.textAlignment = .center
        message.sizeToFit()
        return message
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        backgroundColor = .backGroundLightBlue
//        addPulse()
        setupLayouts()
        setupNotificationsObserver()
        
    }
    private func setupNotificationsObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    func addPulse() {
        let animatingPulse = Pulsing(numberOfPulses: .infinity, radius: 200, position: profileImageView.center)
        animatingPulse.animationDuration = 0.8
        animatingPulse.backgroundColor = UIColor.mainBlue.cgColor
        self.layer.insertSublayer(animatingPulse, below: profileImageView.layer)
        layoutSubviews()
    }
    
    //MARK:- Events
    @objc private func handleEnterForeground() {
        addPulse()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [ profileImageView, bottomLabelMesage].forEach {addSubview($0)}
        profileImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .zero, size: .init(width: imageWidth, height: imageWidth))
        profileImageView.anchorCenter(vertical: centerYAnchor, horizontal: centerXAnchor)
        
        bottomLabelMesage.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 250, right: 20), size: .zero)
    }
}



//UILabel(frame: CGRect(x: UIScreen.main.bounds.midX - (labelWidth/2), y: UIScreen.main.bounds.midY + (labelWidth/2.4), width: labelWidth, height: 76))

//        let imageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.midX - (imageWidth/2), y: UIScreen.main.bounds.midY - (imageWidth/2) - heightDistance, width: imageWidth, height: imageWidth))



//    override func draw(_ rect: CGRect) {
//        if let bigCircle = UIGraphicsGetCurrentContext() {
//            bigCircle.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY - heightDistance), radius: bigCircleRadius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//            bigCircle.setLineWidth(1)
//            UIColor.biggerCircleBlue.setStroke()
//            bigCircle.strokePath()
//
//            pulsatingLayer = CAShapeLayer()
//            pulsatingLayer.path = bigCircle.path
//            pulsatingLayer.strokeColor = UIColor.red.cgColor
//            pulsatingLayer.lineWidth = 10
//            pulsatingLayer.fillColor = UIColor.clear.cgColor
//            pulsatingLayer.lineCap = kCALineJoinRound
////            pulsatingLayer.position = bi
//
//        }
//        if let middleCircle = UIGraphicsGetCurrentContext() {
//            middleCircle.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY - heightDistance), radius: midleCircleRadius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//            middleCircle.setLineWidth(1)
//            UIColor.middleCircleBlue.setStroke()
//            middleCircle.strokePath()
//        }
//        if let smallCircle = UIGraphicsGetCurrentContext() {
//            smallCircle.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY - heightDistance), radius: smallCircleRadius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//            smallCircle.setLineWidth(1)
//            UIColor.mainBlue.setStroke()
//            smallCircle.strokePath()
//        }
//
//
//    }
