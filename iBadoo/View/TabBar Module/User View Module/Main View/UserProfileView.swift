//
//  UserProfileView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 3/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

protocol UserProfileViewDelegate {
    func didSelectImage(image: Image, indexPath: IndexPath, count:Int)
}

class UserProfileView: BaseUIView {
  
    private let aboutCellId = "aboutCellId"
    private let feedCellId = "feedCellId"
    private let mainScreen: CGRect = UIScreen.main.bounds // ?
    
    lazy var testViewController: UserProfileViewController = {
        let controller = UserProfileViewController()
        return controller
    }()
    
    var delegate: UserProfileViewDelegate?
    
    var backAction: (() -> Void)?
    var pushAction: (() -> Void)?
    var showPopUpAction: (() -> Void)?
    
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        testViewController.dismissPopUpTap()
    }
    
    //MARK:- Scroll Elements
    lazy var scroll: UIScrollView = {
        let scroll = UIScrollView(frame: mainScreen)
        return scroll
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let userPhotoView: UserPhotoView = {
        let view = UserPhotoView()
        return view
    }()
    lazy var userMenuView: UserMenuView = {
        let view = UserMenuView()
        view.userProfileView = self
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .backGroundLightBlue
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserInfoCell.self, forCellWithReuseIdentifier: aboutCellId)
        collectionView.register(UserPhotoCell.self, forCellWithReuseIdentifier: feedCellId)
        return collectionView
    }()
    
    //MARK:- Navigations Segment
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09969190141)
        return view
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_white"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more"), for: .normal)
        button.addTarget(self, action: #selector(handleMoreButtonTap), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Life Cicle
    override func setupViews() {
        super.setupViews()
        setupLayouts()
        setupCollectionView()
    }
    private func setupCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
  
    //MARK:- Actions
    @objc private func handleBackButtonTap() {
        backAction?()
    }
    @objc private func handleMoreButtonTap() {
        showPopUpAction?()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        scroll.setContentOffset(CGPoint(x: 0, y: 15), animated: true)
        addSubview(scroll)
        fillSuperView()
        
        scroll.addSubview(containerView)
        containerView.fillSuperView()
        containerView.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
        
        //Scroll Content Elements
        [userPhotoView, userMenuView, collectionView].forEach {containerView.addSubview($0)}
        userPhotoView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 400))
        
        userMenuView.anchor(top: userPhotoView.bottomAnchor, leading: userPhotoView.leadingAnchor, bottom: nil, trailing: userPhotoView.trailingAnchor , padding: .zero, size: .init(width: 0, height: 40))
        
        collectionView.anchor(top: userMenuView.bottomAnchor, leading: userPhotoView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: userPhotoView.trailingAnchor , padding: .zero , size: .init(width: 0, height: UIScreen.main.bounds.height + 60)) // 700
        
        //NavBar Elements
        addSubview(navigationView)
        [backButton, moreButton].forEach { navigationView.addSubview($0)}
        navigationView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 64))
        
        backButton.anchor(top: nil, leading: navigationView.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 10, right: 0), size: .init(width: 14, height: 24))
        
        moreButton.anchor(top: nil, leading: nil, bottom: navigationView.bottomAnchor, trailing: navigationView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 16), size: .init(width: 18, height: 26))
    }
}

//MARK:- Scroll
extension UserProfileView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        userMenuView.horizontalBarLeadinConstraint?.constant = scrollView.contentOffset.x / 2
        testViewController.dismissPopUpTap()
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [], animated: true)
        testViewController.dismissPopUpTap()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / layer.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        self.userMenuView.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        testViewController.dismissPopUpTap()
    }
}

extension UserProfileView: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
}

extension UserProfileView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        switch indexPath.item {
        case 0 :
            return collectionView.dequeueReusableCell(withReuseIdentifier: aboutCellId, for: indexPath)

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellId, for: indexPath) as! UserPhotoCell
            cell.completionHandler = { image, indexPath, count in
                self.delegate?.didSelectImage(image: image, indexPath: indexPath, count: count)
            }
            return cell
        }
        
    }
}

extension UserProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: layer.frame.width, height: layer.frame.height + 25) //  70
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

















