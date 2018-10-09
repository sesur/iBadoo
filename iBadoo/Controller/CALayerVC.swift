//
//  CALayerVC.swift
//  iBadoo
//
//  Created by Sergiu Suru on 4/13/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class CALayerVC: UIViewController {
    
    let maskedView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print("View loaded")
        setupLayouts()
    }
    
    func delay(time: Double, closure: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            closure()
        }
    }
    private func setupLayouts() {
        delay(time: 4) {
            self.view.addSubview(self.maskedView)
            self.maskedView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 300))
            self.maskedView.layoutIfNeeded()
            print("subview Loaded")
        }
    }
}






//let gradientMaskLayer = CAGradientLayer()
//gradientMaskLayer.frame = self.maskedView.bounds
//gradientMaskLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
//gradientMaskLayer.locations = [0, 0.45, 0.95, 0.1]
//self.maskedView.layer.addSublayer(gradientMaskLayer)
////            self.maskedView.layer.insertSublayer(gradientMaskLayer, above: self.view.layer)
//
////            self.maskedView.layer.mask = gradientMaskLayer.superlayer?.mask
////            self.self.maskedView.layer.opacity = 0.5










