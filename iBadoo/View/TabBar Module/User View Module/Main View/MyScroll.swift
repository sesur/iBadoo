//
//  MyScroll.swift
//  
//
//  Created by Sergiu Suru on 3/26/18.
//

import UIKit

class MyScroll: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bgLightBlue
        scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        return hitView == self ? nil : hitView
    }
    
}
