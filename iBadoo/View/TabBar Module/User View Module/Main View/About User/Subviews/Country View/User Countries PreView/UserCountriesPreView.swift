//
//  UserCountriesPreView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 4/6/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserCountriesPreView: UserCountriesView  {
    
    private let cellId = "cellId"
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(UserCountriesCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    //MARK: Life Cycle
    override func setupViews() {
        super.setupViews()
    }
    
    //MARK:- Layouts
    private func setupCollectionViewLayout() {
        addSubview(collectionView)
        collectionView.fillSuperView()
    }
}


extension UserCountriesPreView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!  UserCountriesCell
        cell.countriesCellObserver = countriesArray[indexPath.item]
        return cell
    }
}

extension UserCountriesPreView {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 85)
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
