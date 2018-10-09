//
//  BaseCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/12/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        
    }
}
