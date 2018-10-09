//
//  AboutView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/23/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

protocol AboutDelegate {
    func pushViewController(data: SettingsModel?, indexPath: IndexPath)
}

class AboutAppView: BaseUIView {
    
    private let cellId = "cellId"
    var delegate: AboutDelegate?
    
    let settingArray: [SettingsModel] = {
        let object = [
            SettingsModel.init(nameLabel: .general, imageName: Settings.Image.next.rawValue, subtitle: .empty),
            SettingsModel.init(nameLabel: .phoneNumber, imageName: Settings.Image.next.rawValue, subtitle: .changePhoneNr),
            SettingsModel.init(nameLabel: .aboutApp, imageName: Settings.Image.next.rawValue, subtitle: .empty ),
            SettingsModel.init(nameLabel: .followUs, imageName: Settings.Image.next.rawValue, subtitle: .empty)
        ]
        return object
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(AboutCell.self, forCellWithReuseIdentifier: cellId)
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
        let data = settingArray[indexPath.item]
        if data.nameLabel != SettingsModel.Text.followUs {
            delegate?.pushViewController(data: data, indexPath: indexPath)
        }
        
    }
}

extension AboutAppView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AboutCell {
            cell.aboutCellObserver = settingArray[indexPath.item]
            return cell
        }
        return AboutCell()
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
