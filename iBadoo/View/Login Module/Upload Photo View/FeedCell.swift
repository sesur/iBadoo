//
//  FeedCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/15/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit
import Photos


class FeedCell: BaseCell
{
    private let cellId = "libraryId"
    var libraryImageArray: [Image]?
    
    var completionHandler: (()->())?
    var dismissCompletionHandler: (()->())?
    
    lazy var photoViewControllerObserver: PhotoViewController = {
        let viewController = PhotoViewController()
        return viewController
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)// 56
        collectionView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LibraryCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        setupCollectionViewConstraints()
        getPhotosFromAlbum()
    }
    
    //MARK:- Layouts
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .zero)
    }
    
    //MARK:- Actions
    private func getPhotosFromAlbum() {
        LibraryPhoto.instance.fetchImages { (images) in
            self.libraryImageArray = images
            self.collectionView.reloadData()
        }
    }
}

extension FeedCell: UICollectionViewDelegate {
//        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//
//        }
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let item = collectionView.cellForItem(at: indexPath)
    //        if item?.isSelected ?? false {
    //            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    //            completionHandler?()
    //        } else {
    //            collectionView.deselectItem(at: indexPath, animated: true)
    //            dismissCompletionHandler?()
    //        }
    //    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        completionHandler?()
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let item = collectionView.cellForItem(at: indexPath)
        if item?.isSelected ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            dismissCompletionHandler?()
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            return true
        }
        return false
    }
}

extension FeedCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  libraryImageArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)  as! LibraryCell
        cell.libraryImageObserver = libraryImageArray![indexPath.item]
        return cell
    }
}

extension FeedCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageWidth = (collectionView.bounds.width - 80) / 3.0
        return CGSize(width: imageWidth, height: imageWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
















