//
//  ProfileMenuView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/26/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserMenuView: BaseUIView {
    private let cellHeight: CGFloat = 40
    private let cellId = "cellId"
    var horizontalBarLeadinConstraint: NSLayoutConstraint?
    var userProfileView: UserProfileView?
    
   lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .separatorColor
        collectionView.isScrollEnabled = false
        collectionView.dataSource  = self
        collectionView.delegate = self
        collectionView.register(ProfileMenuCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    let menuProfileArray: [MenuBarModel] = {
        let menuObject = [MenuBarModel(nameLabel: MenuText.about, imageName: "info"),
                          MenuBarModel(nameLabel: MenuText.photos, imageName: "photos") ]
        return menuObject
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        setupLayouts()
        setupCollectionView()
        setupHorizontalBar()
    }
    
    //MARK:- Layouts 
    private func setupCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        let indexPath = IndexPath(item: 0, section: 0) // collectionView.indexPathsForSelectedItems?.first
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        collectionView.showsVerticalScrollIndicator = false
        
    }
    private func setupLayouts() {
        [collectionView].forEach { addSubview($0)}
        collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: cellHeight))
    }
    
    private func setupHorizontalBar() {
        let horizontalBarView = BaseUIView()
        horizontalBarView.backgroundColor = .mainBlue//UIColor(white: 0.95, alpha: 1)
        setupHorizontalBarConstraints(forView: horizontalBarView)
    }
    private func setupHorizontalBarConstraints(forView: UIView) {
        addSubview(forView)
        horizontalBarLeadinConstraint = forView.leadingAnchor.constraint(equalTo: leadingAnchor)
        NSLayoutConstraint.activate([
            horizontalBarLeadinConstraint!,
            forView.bottomAnchor.constraint(equalTo: bottomAnchor),
            forView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            forView.heightAnchor.constraint(equalToConstant: 1.5)
            ])
    }
}

extension UserMenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 2
        horizontalBarLeadinConstraint?.constant = x 
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.userProfileView?.scrollToMenuIndex(menuIndex: indexPath.item)
            self.layoutIfNeeded()
        }, completion: nil)
    }
}

extension UserMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuProfileArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ProfileMenuCell {
            cell.menuCellObserver = menuProfileArray[indexPath.item]
            cell.tintColor = .mainBlue
            return cell
        }
        return ProfileMenuCell()
    }
}

extension UserMenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 2, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
