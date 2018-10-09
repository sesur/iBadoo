//
//  TagListVC.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/17/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
//import TagListView

class TagListVC: UIViewController  {
    
    let testButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Test", for: .normal)
        bt.backgroundColor = .red
        bt.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return bt
    }()
    
    lazy var myView: TestView = {
        let view = TestView()
        view.tagConnectorVC = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismis)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
    }
    
    //MARK:- Actions
    @objc func handleTap() {
        myView.show()
    }
    @objc func handleDismis() {
        myView.hide()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [testButton, myView].forEach { view.addSubview($0)}
        testButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 150, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 30))
        
        myView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -70, right: 0), size: .init(width: 0, height: 70))
    
    }
    

//    private func showAnimation(){
//        if myView.transform == .identity {
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//                self.myView.transform = CGAffineTransform(translationX: 0, y: -70)
//            }, completion: { (true) in
//                
//            })
//        }
//    }
//    private func hideAnimation(){
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//            self.myView.transform = .identity
//        }, completion: { (true) in
//            
//        })
//    }
    
    
    
//
//        private func showAnimation() {
//            let yCoord = view.frame.height - height
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//                self.myView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: .init(top: yCoord, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 70))
//
////                self.myView.frame = CGRect(x: 0, y: yCoord, width: self.view.frame.width, height: self.view.frame.height)
//            }, completion: nil)
//        }
//
//        private func hideAnimation() {
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
//                self.myView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
//            }) { (succese) in
//
//            }
//        }
    
    
    
    
    
    
    //class TagListVC: UIViewController, TagListViewDelegate{
    //
    //     var tagListView: TagListView = {
    //        let tag = TagListView(frame: UIScreen.main.bounds)
    //        tag.textFont = UIFont.systemFont(ofSize: 24)
    //        tag.borderWidth = 1
    //        tag.borderColor = .red
    //        tag.backgroundColor = .blue
    //        tag.paddingX = 5
    //        tag.paddingY = 5
    //        return tag
    //    }()
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        view.backgroundColor = .white
    //        setupTagList()
    //    }
    //
    //    private func setupTagList() {
    //        view.addSubview(tagListView)
    //
    ////        tagListView.delegate = self
    //        tagListView.addTags(["test", "tstcsc", "agcasc"])
    //        tagListView.textColor = .red
    //        print(tagListView)
    //
    //
    //        let tagView = tagListView.addTag("gray")
    //        tagView.tagBackgroundColor = UIColor.gray
    //        tagView.onTap = { tagView in
    //            print("Don’t tap me!")
    //        }
    //
    //    }
    //}
    
}
