//
//  LanguagesView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserLanguageView: BaseUIView {
    
    private let cellId = "cellId"
    
    let languagesArray: [LanguageModel?] = {
        let object = [
            LanguageModel(know: .know, language: "English"),
            LanguageModel(know: .know, language: "Romanian"),
            LanguageModel(know: .know, language: "French")
        ]
        return object
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(UserLanguagesCell.self, forCellWithReuseIdentifier: cellId)
        return cv
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

extension UserLanguageView: UICollectionViewDelegate {
    
}

extension UserLanguageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languagesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserLanguagesCell
        cell.userLanguangeCellObserver = languagesArray[indexPath.item]
        return cell
    }
}

extension UserLanguageView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

