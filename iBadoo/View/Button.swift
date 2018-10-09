//
//  Button.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/18/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class Button: UIButton {
    typealias DidTapButton = (UIButton) -> ()
    
    var didTouchUpInside: DidTapButton? {
        didSet {
            if didTouchUpInside != nil {
                addTarget(self, action: #selector(didTouchUpInside(sender:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(didTouchUpInside(sender:)), for: .touchUpInside)
            }
        }
    }

   @objc func didTouchUpInside(sender: UIButton) {
        if let handler = didTouchUpInside {
            handler(self)
        }
    }
    
    
}
