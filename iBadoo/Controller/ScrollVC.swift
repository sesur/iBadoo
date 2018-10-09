//
//  ScrollVC.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/16/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class ScrollVC : UIViewController {
    
    
    private let scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        //scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 800)
        return scroll
    }()
    
    private let containverScrollView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var testeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "I Got the bottom freeform VC"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    }()
    
    private var backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 50, height: 50))
        button.setTitle("back", for: .normal)
        button.setTitleColor(button.tintColor, for: .normal)
        button.addTarget(self, action: #selector(hangleTap), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()
    
    var didSelect: () -> () = { }
    
    @objc private func hangleTap() {
         didSelect()
        }
        
//        backButton.
        
//        let profileVC = ProfileInfoVC()
//        present(profileVC, animated: true, completion: nil)
////        pushViewController(profileVC, animated: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containverScrollView.addSubview(backButton)
        
        view.backgroundColor = .blue
        setupScrollViewLayout()
//        scrollView.contentSize = containverScrollView.frame.size
//        scrollView.autoresizingMask = [.flexibleHeight]
       
        setupContainerScrollViewLayouts()
        setupTestLabelLayouts()
        
        //hangleTap()
    }

    
    private func setupScrollViewLayout(){
       // scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1900)
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 92),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func setupContainerScrollViewLayouts() {
        scrollView.addSubview(containverScrollView)
        NSLayoutConstraint.activate([
            containverScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // the most important feature
            
            containverScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containverScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containverScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containverScrollView.leadingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
    }
    
        private func setupTestLabelLayouts() {
            containverScrollView.addSubview(testeLabel)
            NSLayoutConstraint.activate([
                testeLabel.topAnchor.constraint(equalTo: containverScrollView.topAnchor, constant: 1200),
                testeLabel.heightAnchor.constraint(equalToConstant: 50),

                testeLabel.leadingAnchor.constraint(equalTo: containverScrollView.leadingAnchor, constant: 32),
                testeLabel.trailingAnchor.constraint(equalTo: containverScrollView.trailingAnchor, constant: -32),
                testeLabel.bottomAnchor.constraint(equalTo:containverScrollView.bottomAnchor, constant: -20)
                ])
        }

    
}
