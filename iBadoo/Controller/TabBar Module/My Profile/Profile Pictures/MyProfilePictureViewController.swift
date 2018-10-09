//
//  MyProfilePictureViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/26/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class MyProfilePictureViewController: UIViewController {
    
    private let cellId = "cellId"
    private var libraryImageArray: [Image]?
    private var selectionNumber: Int = 0
    
    private func getPhotosFromAlbum() {
        LibraryPhoto.instance.fetchImages { (images) in
            self.libraryImageArray = images
            self.collectionView.reloadData()
        }
    }
    var profilePictureItem: MyProfileModel? {
        didSet {
            navigationItem.title = profilePictureItem?.nameLabel.rawValue
        }
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        collectionView.register(LibraryCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    // MARK:- DeletePopUpView
    private let deletePopUpView: DeletePopUpView = {
        let view = DeletePopUpView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLayouts()
        getPhotosFromAlbum()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideNavigationTabBar(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        hideNavigationTabBar(false)
    }
    private func setupNavigation() {
        if let topNav = self.navigationController?.navigationBar.topItem {
            topNav.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "upload"), style: .plain, target: self, action: #selector(handleUploadTap))
    }
    private func setupLayouts() {
        view.backgroundColor = .white
        [collectionView, deletePopUpView].forEach { view.addSubview($0) }
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 85, left: 20, bottom: 0, right: 20), size: .zero)
        
        deletePopUpView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -70, right: 0), size: .init(width: 0, height: 70)) // bottom = -70
    }
    
    //MARK:- Events
    @objc private func handleUploadTap() {
        print("Upload button tapped")
    }
}


extension MyProfilePictureViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        selectionNumber += 1
        deletePopUpView.show()
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectionNumber -= 1
        if selectionNumber == 0 {
            deletePopUpView.hide()
        }
    }
    //    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    //        let item = collectionView.cellForItem(at: indexPath)
    //        if item?.isSelected ?? false {
    //            collectionView.deselectItem(at: indexPath, animated: true)
    //
    //        } else {
    //            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    //        }
    //        return true
    //    }
}

extension MyProfilePictureViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = libraryImageArray?.count {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LibraryCell
        let image = libraryImageArray![indexPath.row]
        cell.libraryImageObserver = image
        return cell
    }
}

extension MyProfilePictureViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 112, height: 112)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
