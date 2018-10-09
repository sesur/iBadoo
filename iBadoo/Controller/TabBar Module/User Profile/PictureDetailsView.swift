//
//  PictureDetailsView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 4/6/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class PictureDetailsView: BaseUIView {
    
    private let cellId = "cellID"
    var libraryImageArray: [Image]?
    
    private func getPhotosFromAlbum() {
        LibraryPhoto.instance.fetchImages { (images) in
            self.libraryImageArray = images
            self.collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserPictureDetailsCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1030479754)
        return view
    }()
    private let numberOfphotosLabel: UILabel = {
        let label = UILabel()
            label.attributedText = AttributedStringHelper.getString(text: "Photo \(String(describing: 1)) from  ...",
                fontType: .regular, size: 22, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        label.sizeToFit()
        return label
    }()
    
    
    //MARK:- Life Cicle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
        getPhotosFromAlbum()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [collectionView, bottomView ].forEach { addSubview($0) }
        collectionView.fillSuperView()
        setupCollectionView()
    
        bottomView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size:.init(width: 0, height: 80))
        
        [numberOfphotosLabel].forEach {bottomView.addSubview($0)}
        numberOfphotosLabel.anchor(top: nil, leading: nil, bottom: bottomView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 26, right: 0), size: .zero)
        numberOfphotosLabel.anchorCenter(vertical: nil, horizontal: bottomView.centerXAnchor)
    }
    private func setupCollectionView() {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}


extension PictureDetailsView: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / layer.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0).row + 1
        if let count = libraryImageArray?.count {
           updateBottomLabel(totalImages: count, indexPath: indexPath)
        }
    }
}

extension PictureDetailsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return libraryImageArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)  as! UserPictureDetailsCell
        cell.libraryImageObserver = libraryImageArray![indexPath.item]
        return cell
    }
    
    private func updateBottomLabel(totalImages: Int , indexPath: Int) {
        numberOfphotosLabel.attributedText = AttributedStringHelper.getString(text: "Photo \(String(describing: indexPath)) from \(String(describing: totalImages))",
            fontType: .regular, size: 22, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
}

extension PictureDetailsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}





