//
//  PictureDetailsViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/28/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class PictureDetailsViewController: UIViewController {
    
    var image: Image?
    var index: Int?
    var totalImagesCounted: Int? 
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09969190141)
        return view
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleCloseButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleMoreButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let pictureDetailsView: PictureDetailsView = {
        let view = PictureDetailsView()
        return view
    }()
    
    
    // from here
    let pictureImageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        return imv
    }()
    
//    private let bottomView: UIView = {
//        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1030479754)
//        return view
//    }()
//    private let numberOfphotosLabel: UILabel = {
//        let label = UILabel()
//        label.sizeToFit()
//        return label
//    }()
    //till  here
    
    //MARK:- Actions
    @objc private func handleCloseButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func handleMoreButtonTap() {
        print("more button pressed")
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        updateViewContent()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        UIApplication.shared.isStatusBarHidden = true
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        UIApplication.shared.isStatusBarHidden = false
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    private func updateViewContent() {
//        guard let picture = image?.imageThumbNails else {return}
//        pictureImageView.image = picture
//        if let index = index, let totalImages = totalImagesCounted {
//            numberOfphotosLabel.attributedText = AttributedStringHelper.getString(text: "Photo \(String(describing: index)) from \(String(describing: totalImages))", fontType: .regular, size: 22, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
//        }
    }
 
    
    //MARK:- Layouts
    private func setupLayouts() {
//        pictureImageView, bottomView,
        [pictureDetailsView,  navigationView].forEach { view.addSubview($0)}
//        pictureImageView.fillSuperView()
        
        [closeButton, moreButton].forEach { navigationView.addSubview($0)}
        navigationView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0  ), size: .init(width: 0, height: 64))
        
        closeButton.anchor(top: nil, leading: navigationView.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 23, bottom: 8, right: 0), size: .init(width: 21, height: 24))
        
        moreButton.anchor(top: closeButton.topAnchor, leading: nil, bottom: closeButton.bottomAnchor, trailing: navigationView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 23), size: .init(width: 6, height: 0))
        
//        bottomView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size:.init(width: 0, height: 80))
//        
//        [numberOfphotosLabel].forEach {bottomView.addSubview($0)}
//        numberOfphotosLabel.anchor(top: nil, leading: nil, bottom: bottomView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 26, right: 0), size: .zero)
//        numberOfphotosLabel.anchorCenter(vertical: nil, horizontal: bottomView.centerXAnchor)
        
        pictureDetailsView.fillSuperView()
        
//        pictureDetailsView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
    }
}
