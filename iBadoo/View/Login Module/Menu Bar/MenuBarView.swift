//
//  MenuBarView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/12/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class MenuBarView: BaseUIView {
    
    private let cellHeight: CGFloat = 92
    private let cellId = "cellId"
    var horizontalBarLeadinConstraint: NSLayoutConstraint?
    var photoViewController: PhotoViewController?
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .mainBlue
        collectionView.isScrollEnabled = false
        collectionView.dataSource  = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    let menuBarArray: [MenuBarModel] = {
        let menuObject = [MenuBarModel(nameLabel: MenuText.camera, imageName: "camera"),
                          MenuBarModel(nameLabel: MenuText.library, imageName: "gallery") ]
        return menuObject
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        setupCollectionView()
        setupHorizontalBar()
        setupLayouts()
    }
    private func setupCollectionView() {
        let indexPath = IndexPath(item: 0, section: 0) // collectionView.indexPathsForSelectedItems?.first
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
    
    //MARK:- Layouts
    private func setupHorizontalBar() {
        let horizontalBarView = BaseUIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        setupHorizontalBarConstraints(forView: horizontalBarView)
    }
    private func setupHorizontalBarConstraints(forView: UIView) {
        addSubview(forView)
        horizontalBarLeadinConstraint = forView.leadingAnchor.constraint(equalTo: leadingAnchor)
        NSLayoutConstraint.activate([
            horizontalBarLeadinConstraint!,
            forView.bottomAnchor.constraint(equalTo: bottomAnchor),
            forView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            forView.heightAnchor.constraint(equalToConstant: 3)
            ])
    }
    private func setupLayouts() {
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: cellHeight))
    }
}


extension MenuBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 2
        horizontalBarLeadinConstraint?.constant = x
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.photoViewController?.scrollToMenuIndex(menuIndex: indexPath.item)
            self.layoutIfNeeded()
        }, completion: nil)
    }
}

extension MenuBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBarArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.menuCellObserver = menuBarArray[indexPath.item]
        cell.tintColor = #colorLiteral(red: 0.3487198353, green: 0.4947527647, blue: 0.9329457879, alpha: 1)
        return cell
    }
}

extension MenuBarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}













