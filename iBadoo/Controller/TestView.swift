//
//  TestView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 3/20/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class TestView: BaseUIView {
    
    let height:CGFloat = 70
    
    lazy var tagConnectorVC: TagListVC = {
        let connector = TagListVC()
        return connector
    }()
    
    private lazy var button: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .green
        bt.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        bt.setGradientBackground(topColor: .red, bottomColor: .blue)
        return bt
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .orange
        setupLayouts()
    }
    
    private func setupLayouts(){
        addSubview(button)
        button.fillSuperView()
    }
    @objc func handleTap() {
        print("Test button")
        hide()

    }
    
    func show(){
        showAnimation()
    }
    func hide(){
        hideAnimation()
    }
    
    private func showAnimation(){
        if self.transform == .identity {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -70)
            }, completion: { (true) in
                
            })
        }
    }
    private func hideAnimation(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: { (true) in
            
        })
    }
    
    
    
    
//    private func showAnimation() {
////        let yCoord = view.frame.height - height
//        let test = UIScreen.main.bounds.height - height
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//
//
////        addSubview(self)
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//            self.layer.frame = CGRect(x: 0, y: test, width: screenWidth, height: screenHeight)
//        }, completion: nil)
//    }
//
//    func hideAnimation() {
//
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
//            self.frame = CGRect(x: 0, y: self.frame.height, width: screenWidth, height: screenHeight)
//        }) { (succese) in
//
//        }
//    }
    
}
