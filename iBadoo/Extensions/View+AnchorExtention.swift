//
//  View+AnchorExtention.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/15/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    func anchorSize(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchorCenter(vertical: NSLayoutYAxisAnchor?, horizontal: NSLayoutXAxisAnchor?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let vertical = vertical {
            centerYAnchor.constraint(equalTo: vertical).isActive = true
        }
        if let horizontal = horizontal {
            centerXAnchor.constraint(equalTo: horizontal).isActive = true
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}



//extension UIViewController {
//    func dismissMe(animated: Bool, completion: (()->())?) {
//        var count = 0
//        if let c = self.navigationController?.viewControllers.count {
//            count = c
//        }
//        if count > 1 {
//            self.navigationController?.popViewController(animated: animated)
//            if let handler = completion {
//                handler()
//            }
//        } else {
//            dismiss(animated: animated, completion: completion)
//        }
//    }
//}





