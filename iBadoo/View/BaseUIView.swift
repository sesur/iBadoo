//
//  BaseUIView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/15/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class BaseUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        
    }
    
}
