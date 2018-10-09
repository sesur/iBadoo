//
//  DeletePopUpView.swift
//  iBadoo
//
//  Created by Sergiu on 5/7/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class DeletePopUpView: BaseUIView {
    private let cellId = "deleteCellId"
    private let cellHeight: CGFloat = 70
    
    private let deletePopUpArray: [PopUpModel] = {
        return [PopUpModel(name:"Delete selected picture(s)", imageName: "delete")]
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(DeletePopUpCell.self, forCellWithReuseIdentifier: cellId)
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
        backgroundColor = #colorLiteral(red: 1, green: 0.3215686275, blue: 0.2862745098, alpha: 0.8956014555)
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
}

extension DeletePopUpView: UICollectionViewDelegate  {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        photoViewControllerObserver.collectionView.deselectItem(at: indexPath, animated: true)

    }
}

extension DeletePopUpView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deletePopUpArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DeletePopUpCell
        cell.deleteObserver = deletePopUpArray[indexPath.item]
        return cell
    }
}

extension DeletePopUpView: UICollectionViewDelegateFlowLayout  {
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
