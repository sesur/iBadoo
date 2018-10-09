//
//  UserPopUpView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 4/10/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserPopUpView: BaseUIView {
    private let cellId = "cellId"
    private let cellHeight: CGFloat = 35
    private let userPopUpArray: [PopUpModel] = {
        return [PopUpModel(name:"View profile", imageName: "nil "),
                PopUpModel(name:"Add to favorites ", imageName: "nil "),
                PopUpModel(name:"Write a message", imageName: "nil "),
                PopUpModel(name:"Block", imageName: "nil ")]
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.register(UserPopUpViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    lazy var photoViewControllerObserver: PhotoViewController = {
        let launcher = PhotoViewController()
        return launcher
    }()
    
    //MARK: Life Cycle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        addSubview(collectionView)
        collectionView.fillSuperView()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    //MARK:- Animations
    func show() {
        showAnimation()
    }
    @objc func hide() {
        hideAnimation()
    }
    
    private func showAnimation(){
        if self.transform == .identity {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform(translationX: -245, y: 0)  //CGAffineTransform(translationX: 0, y: -70)
            }, completion: { (true) in })
        }
    }
    private func hideAnimation(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: { (true) in })
    }
    
    
}


extension UserPopUpView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        photoViewControllerObserver.collectionView.deselectItem(at: indexPath, animated: true)
//        hidePopUpAndPushViewcontroller()
    }
}

extension UserPopUpView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPopUpArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserPopUpViewCell
        cell.uploadObserver = userPopUpArray[indexPath.item]
        return cell
    }
}

extension UserPopUpView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



