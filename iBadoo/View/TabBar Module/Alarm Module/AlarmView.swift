//
//  AlarmView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/5/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class AlarmView: BaseUIView {
    
    private let cellId = "cellId"
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .backGroundColor
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    override func setupViews() {
        super.setupViews()
        setupCollectionViewLayout()
    }
    
    private func setupCollectionViewLayout() {
        addSubview(collectionView)
        collectionView.register(AlarmCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 64, left: 0, bottom: 0, right: 0))
    }
}


extension AlarmView: UICollectionViewDelegate {
    
}
extension AlarmView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AlarmCell
        cell.acceptButton.didTouchUpInside = { (sender) in
            
        }
        return cell
    }
}
extension AlarmView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 201)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
