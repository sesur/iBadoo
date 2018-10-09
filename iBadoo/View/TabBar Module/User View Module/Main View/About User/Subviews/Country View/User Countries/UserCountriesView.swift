//
//  UserCountriesView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserCountriesView: BaseUIView {
    
    private let cellId = "cellId"
    
     let countriesArray: [CountryModel?] = {
        let object = [
            CountryModel(wasIn: .wasIn, location: "London, Great Britain", time: "Yesterday"),
            CountryModel(wasIn: .wasIn, location: "New York, Unated States of America", time: "21 September 2017"),
            CountryModel(wasIn: .wasIn, location: "Frankfurt am Main, Germany", time: "15 July 2017"),
            CountryModel(wasIn: .wasIn, location: "Milano, Italy", time: "13 July 2017"),
            CountryModel(wasIn: .wasIn, location: "Chisinau, Republic of Moldova", time: "11 May 2017"),
            CountryModel(wasIn: .wasIn, location: "Balti, Republic of Moldova", time: "11 May 2017"),
            CountryModel(wasIn: .wasIn, location: "Moscow, Russia", time: "8 February 2017"),
            CountryModel(wasIn: .wasIn, location: "Iasi, Romania", time: "20 January 2017")
            ]
        return object
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UserCountriesCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        setupCollectionViewLayout()
    }
    
    private func setupCollectionViewLayout() {
        addSubview(collectionView)
        collectionView.fillSuperView()
    }
}

extension UserCountriesView: UICollectionViewDelegate {
    
}

extension UserCountriesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countriesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!  UserCountriesCell
        cell.countriesCellObserver = countriesArray[indexPath.item]
        return cell
    }
}

extension UserCountriesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 85)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
