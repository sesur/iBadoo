//
//  PhotoViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/12/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    private let feedCellId = "cellId"
    private let cameraCellId = "cameraCellId"
    private let libraryCellId = "libraryCellId"
    
    lazy var menuBarView: MenuBarView = {
        let menu = MenuBarView()
        menu.photoViewController = self
        return menu
    }()
    lazy var uploadPopUpView: UploadPopUpView = {
        let view = UploadPopUpView()
        view.photoViewControllerConnector = self
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
        collectionView.register(CameraCell.self, forCellWithReuseIdentifier: cameraCellId)
        return collectionView
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        collectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        UIApplication.shared.statusBarStyle = .lightContent
        view.backgroundColor = .mainBlue
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        UIApplication.shared.statusBarStyle = .default
    }
    
    //MARK:- Layouts
    private func  setupLayouts() {
        [menuBarView, collectionView, uploadPopUpView].forEach {view.addSubview($0)}
        menuBarView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: 92))
        collectionView.anchor(top: menuBarView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .zero)
        
        uploadPopUpView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -70, right: 0), size: .init(width: 0, height: 70)) // bottom = -70
    }
    
    //MARK:- Scroll
    func scrollToMenuIndex(menuIndex: Int) {
        UIView.animate(withDuration: 0.5, animations: {
            let indexPath = IndexPath(item: menuIndex, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }) { (true) in
            self.uploadPopUpView.hide()
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBarView.horizontalBarLeadinConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.5, animations: {
            let index = targetContentOffset.pointee.x / self.view.frame.width
            let indexPath = IndexPath(item: Int(index), section: 0)
            self.menuBarView.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }) { (true) in
            self.uploadPopUpView.hide()
        }
    }
    
    //MARK:- Navigation
    func showProfileInfoVC() {
        navigationController?.pushViewController(ProfileInfoViewController(), animated: true)
    }
    
}


extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0 :
            return collectionView.dequeueReusableCell(withReuseIdentifier: cameraCellId, for: indexPath)
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellId, for: indexPath) as! FeedCell
            cell.completionHandler = {
                self.didShowPopUp()
            }
            cell.dismissCompletionHandler = {
                self.didHidePopUp()
                collectionView.deselectItem(at: indexPath, animated: true)
            }
            return cell
        }
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 92) //  - 92
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension  PhotoViewController: UploadPopUpViewDelegate {
    internal func didShowPopUp() {
        uploadPopUpView.show()
    }
    internal func didHidePopUp() {
        uploadPopUpView.hide()
    }
}




















