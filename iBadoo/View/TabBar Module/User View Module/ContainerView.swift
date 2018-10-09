//
//  ContainerView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class ContainerView: BaseUIView {
    private let aboutCellId = "aboutCellId"
    private let feedCellId = "feedCellId"
    
    
    lazy var profileMenu: ProfileMenuView = {
        let menu = ProfileMenuView()
//        menu.containerVC = self
        return menu
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(AboutFriendCell.self, forCellWithReuseIdentifier: aboutCellId)
        cv.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        setupLayout()
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
    }
    private func setupLayout(){
        [collectionView].forEach { addSubview($0) }
        collectionView.fillSuperView()
        collectionView.isScrollEnabled = true
        
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        profileMenu.horizontalBarLeadinConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.x / frame.width)
        
        
        
        let index = targetContentOffset.pointee.x / frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}


extension ContainerView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(123)
    }
}

extension ContainerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        switch indexPath.item {
        case 0 : identifier = aboutCellId
        default:
            identifier = feedCellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
}

extension ContainerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height - 92)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
