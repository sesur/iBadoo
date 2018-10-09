//
//  AboutView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

protocol AboutAppDelegate {
    func pushViewController(data: SettingsModel?, indexPath: IndexPath)
}

class AboutAppView: BaseUIView {
    
    private let cellId = "cellId"
    var delegate: AboutAppDelegate?

    let aboutAppArray: [SettingsModel] = {
        let object = [
            SettingsModel.init(nameLabel: .termsAndConditions, imageName: Settings.Image.next.rawValue, subtitle: .empty),
            SettingsModel.init(nameLabel: .privacyAndPolicy, imageName: Settings.Image.next.rawValue, subtitle: .empty),
            SettingsModel.init(nameLabel: .appVersion, imageName: Settings.Image.next.rawValue, subtitle: .appExactVersion),
            
        ]
        return object
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(AboutAppCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()

    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        setupLayout()
    }
    private func setupLayout(){
        [collectionView].forEach { addSubview($0) }
        collectionView.fillSuperView()
        collectionView.isScrollEnabled = false
    }
}


extension AboutAppView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = aboutAppArray[indexPath.item]
//        if data.nameLabel != SettingsModel.Text.appVersion {
            delegate?.pushViewController(data: data, indexPath: indexPath)
//        }
    }
}

extension AboutAppView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aboutAppArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AboutAppCell {
            cell.aboutAppCellObserver = aboutAppArray[indexPath.item]
            return cell
        }
        return AboutAppCell()
    }
}

extension AboutAppView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 65)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

