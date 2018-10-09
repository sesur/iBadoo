//
//  UploadPopUpView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/20/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

struct PopUpModel {
    let name: String
    let imageName: String
}

protocol UploadPopUpViewDelegate {
    func didShowPopUp()
    func didHidePopUp()
}

class UploadPopUpView: BaseUIView {
    
    private let cellId = "launcherCellId"
    private let cellHeight: CGFloat = 70
    
    private let popUpArray: [PopUpModel] = {
        return [PopUpModel(name:"Upload 1 image", imageName: "upload")]
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear 
        collectionView.register(UploadPopUpCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var photoViewControllerConnector: PhotoViewController = {
        let connector = PhotoViewController()
        return connector
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        super.setupViews()
        backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.2745098039, blue: 0.8901960784, alpha: 0.9024500169)
        addSubview(collectionView)
        collectionView.fillSuperView()
    }
    
    //MARK:- Actions
    func show(){
        showAnimation()
    }
    func hide(){
        hideAnimation()
    }
    
    //MARK:- Animations
    private func showAnimation(){
        if self.transform == .identity {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -70)
            }, completion: { (true) in })
        }
    }
    private func hideAnimation(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: { (true) in })
    }
    
    private func hidePopUpAndPushViewcontroller(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: { (true) in
            self.photoViewControllerConnector.showProfileInfoVC()
        })
    }
}

extension UploadPopUpView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoViewControllerConnector.collectionView.deselectItem(at: indexPath, animated: true)
        hidePopUpAndPushViewcontroller()
    }
}

extension UploadPopUpView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popUpArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UploadPopUpCell
        cell.uploadObserver = popUpArray[indexPath.item]
        return cell
    }
}

extension UploadPopUpView: UICollectionViewDelegateFlowLayout {
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

















