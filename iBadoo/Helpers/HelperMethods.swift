//
//  HelperMethods.swift
//  iBadoo
//
//  Created by Sergiu on 8/14/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import FirebaseFirestore

extension UIViewController {
    
    func hideNavigationTabBar(_ isTrue: Bool = true) {
        guard let customTabBar = tabBarController as? CustomTabBarController else {return}
        if isTrue {
            customTabBar.animationTabBarHidden(true)
        }
        else {
            customTabBar.animationTabBarHidden(false)
        }
        
//        let value = isTrue ? customTabBar.animationTabBarHidden(isTrue): customTabBar.animationTabBarHidden(isTrue)
        
        
        
//        if isTrue == true {
//            return customTabBar.animationTabBarHidden(isTrue)
//        }
//        return customTabBar.animationTabBarHidden(isTrue)
    }
}


//MARK: GLOBAL FUNCTIONS
private let dateFormat = "yyyyMMddHHmmss"

func dateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
    dateFormatter.dateFormat = dateFormat
    return dateFormatter
}
