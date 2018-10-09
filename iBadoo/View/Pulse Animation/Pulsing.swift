//
//  Pulsing.swift
//  iBadoo
//
//  Created by Sergiu Suru on 4/13/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
class Pulsing: CALayer {
    var animationGroup = CAAnimationGroup()
    
    var initialPulseScale: Float = 0
    var nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numberOfPulses: Float = .infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(numberOfPulses: Float = .infinity, radius: CGFloat, position: CGPoint ) {
        super.init()
        backgroundColor = UIColor.black.cgColor
        contentsScale = UIScreen.main.scale
        opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2 , height: radius * 2)
        cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroupe()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        return opacityAnimation
    }
    func setupAnimationGroupe() {
        animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + nextPulseAfter
        animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animationGroup.timingFunction = defaultCurve
        
        animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
}






















