//
//  FavoritesView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/4/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class FavoritesView: BaseUIView {
    
    private let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let colectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colectionView.translatesAutoresizingMaskIntoConstraints = false
        colectionView.delegate = self
        colectionView.dataSource = self
        colectionView.backgroundColor = .backGroundColor
        return colectionView
    }()

    //MARK:- Setups
    override func setupViews() {
        super.setupViews()
        setupCollectionViewLayout()
    }
    private func setupCollectionViewLayout() {
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        collectionView.fillSuperView()
    }
}

extension FavoritesView: UICollectionViewDelegate {
    
}

extension FavoritesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FavoritesCell
        return cell
    }
}

extension FavoritesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 101)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
