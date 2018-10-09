//
//  UINavigation+Extension.swift
//  iBadoo
//
//  Created by Sergiu Suru on 3/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

extension UINavigationController {

    func initRootViewController(viewController: UIViewController, transitionType type: String = convertFromCATransitionType(CATransitionType.fade), duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.viewControllers.removeAll()
        self.pushViewController(viewController, animated: false)
        self.popToRootViewController(animated: false)
    }
    
    private func addTransition(transitionType type: String = convertFromCATransitionType(CATransitionType.fade), duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = convertToCATransitionType(type)
        self.view.layer.add(transition, forKey: nil)
    }
    
    func root(viewController: UIViewController, transitionType type: String = convertFromCATransitionType(CATransitionType.fade), duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.viewControllers.removeAll()
        navigationController?.initRootViewController(viewController: viewController)
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}
