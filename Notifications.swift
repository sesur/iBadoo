//
//  Notifications.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/17/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation


//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }

//    var bottomConstraint: NSLayoutConstraint?
//
//    @objc func keyboardHandler(notification: NSNotification) {
//        if let userInfo = notification.userInfo {
//            guard let keyboardSize = ((userInfo[UIKeyboardFrameBeginUserInfoKey]) as AnyObject).cgRectValue else {return}
//            let isKeyboardShowing = notification.name == .UIKeyboardWillShow
//            bottomConstraint?.constant = isKeyboardShowing ? -keyboardSize.height : -112
//
//            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
//                self.view.layoutIfNeeded()
//            }, completion: { (completed) in
//                if isKeyboardShowing {
//                    // self.yourHobbiesTextField.isHidden = true
//                    // self.languageKnowTextField.isHidden = true
//                }
//            })
//        }
//    }

//    private func registerTheKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(ProfileInfoVC.keyboardHandler), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(ProfileInfoVC.keyboardHandler), name: .UIKeyboardWillHide, object: nil)
//
//        bottomConstraint = NSLayoutConstraint(item: tagsView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -112)
//        view.addConstraint(bottomConstraint!)
//
//    }

