//
//  UploadProfileViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/11/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class UploadProfileViewController: UIViewController {
    
//    lazy var photoViewController: PhotoViewController = {
//        let menu = PhotoViewController()
//        return menu
//    }()
    
    private let customView: UploadProfileView = {
        let view = UploadProfileView()
        return view
    }()
    private lazy var cameraBtton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "camera"), for: .normal)
        button.addTarget(self, action: #selector(handleCameraButtonPressed), for: .touchUpInside)
        return button
    }()
    private lazy var libraryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gallery"), for: .normal)
        button.addTarget(self, action: #selector(handleLibraryButtonPressed), for: .touchUpInside)
        return button
    }()
    private lazy var cameraTitle: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(AttributedStringHelper.getString(text: Camera.camera.rawValue , fontType: .regular, size: 22, color: .white), for: .normal)
        button.addTarget(self, action: #selector(handleCameraButtonPressed), for: .touchUpInside)
        return button
    }()
    private lazy var libraryTitle: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(AttributedStringHelper.getString(text: Camera.library.rawValue , fontType: .regular, size: 22, color: .white), for: .normal)
        button.addTarget(self, action: #selector(handleLibraryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        UIApplication.shared.statusBarStyle = .default
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
    }
    
    //MARK:- Actions & Navigation
    @objc private func handleCameraButtonPressed() {
        navigationController?.pushViewController(PhotoViewController(), animated: true)
    }
    @objc private func handleLibraryButtonPressed() {
        navigationController?.pushViewController(PhotoViewController(), animated: true)
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [customView].forEach {view.addSubview($0)}
        customView.fillSuperView()
        
        let cameraStack = UIStackView(arrangedSubviews: [cameraBtton, cameraTitle])
        let libraryStack = UIStackView(arrangedSubviews: [libraryButton, libraryTitle])
        [cameraStack, libraryStack].forEach {
            customView.addSubview($0)
            $0.axis = .vertical
            $0.distribution = .fillProportionally
            $0.alignment = .fill
            $0.spacing = 20
        }
        
        cameraStack.anchor(top: customView.topAnchor, leading: customView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 130, left: 68, bottom: 0, right: 0), size: .init(width: 80, height: 120))

        libraryStack.anchor(top: cameraBtton.topAnchor, leading: nil, bottom: nil, trailing: customView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 68), size: .init(width: 80, height: 120))
    }
}




























