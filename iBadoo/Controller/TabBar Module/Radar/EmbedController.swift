//
//  EmbedController.swift
//  iBadoo
//
//  Created by Sergiu on 8/18/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class EmbedController {
    public private (set) weak var rootViewController: UIViewController?
    public private (set) var controllers = [UIViewController]()
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func append(viewController: UIViewController) {
        if let rootViewController = self.rootViewController {
            controllers.append(viewController)
            rootViewController.addChild(viewController)
            rootViewController.view.addSubview(viewController.view)
        }
    }
    
    func remove(viewController: UIViewController) {
        if self.rootViewController != nil {
            controllers.forEach({
                $0.removeFromParent()
                $0.view.removeFromSuperview()
            })
        }
        controllers.removeAll()
        self.rootViewController = nil
    }
    
    deinit {
        if self.rootViewController != nil {
           controllers.forEach({
            $0.removeFromParent()
            $0.view.removeFromSuperview()
           })
        }
        controllers.removeAll()
        self.rootViewController = nil
    }
}
