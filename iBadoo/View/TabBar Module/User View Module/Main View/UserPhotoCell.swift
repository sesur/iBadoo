//
//  UserPhotoCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import Photos

class UserPhotoCell: BaseCell
{
    private let cellId = "libraryId"
    var libraryImageArray: [Image]?
    
    var completionHandler: ((Image, IndexPath, Int)->())?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backGroundLightBlue
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LibraryCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    //MARK: - Life Cycle
    override func setupViews() {
        setupCollectionViewConstraints()
        getPhotosFromAlbum()
    }
    private func getPhotosFromAlbum() {
        LibraryPhoto.instance.fetchImages { (images) in
            self.libraryImageArray = images
            self.collectionView.reloadData()
        }
    }
    
    //MARK:- Layouts
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.fillSuperView()
    }
}

extension UserPhotoCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  libraryImageArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)  as! LibraryCell
        if let item = libraryImageArray?[indexPath.item] {
            cell.libraryImageObserver = item
        }
        return cell
    }
}

extension UserPhotoCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let totalImages = libraryImageArray?.count {
            let image = libraryImageArray![indexPath.item]
            completionHandler?(image, indexPath, totalImages)
        }
    }
}

extension UserPhotoCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageWidth = (collectionView.bounds.width - 80) / 3.0
        return CGSize(width: imageWidth, height: imageWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

