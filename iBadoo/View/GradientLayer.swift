//
//  GradientLayer.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/26/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

extension UIView {
    
    func setGradientBackground(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.colors = [topColor, bottomColor]
//        gradientLayer.locations = [0.0, 2.0]
//        gradientLayer.startPoint = CGPoint(x: 1.0, y: 2.0)
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 2.0)
        
//        self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

