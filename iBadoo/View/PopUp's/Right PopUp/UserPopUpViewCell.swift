//
//  UserPopUpViewCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 4/11/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserPopUpViewCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = self.isHighlighted ? .lightGray : .white // #colorLiteral(red: 0.4175875521, green: 0.7350258943, blue: 0.9511632777, alpha: 1) : #colorLiteral(red: 0.04790695012, green: 0.3381513953, blue: 0.9071245193, alpha: 0.7037026849)
            
            messageLabel.textColor = self.isHighlighted ? .white : .black
        }
    }
    
    var uploadObserver: PopUpModel? {
        didSet {
            guard let unwrappedUploadCell = uploadObserver else { return }
            
            imageView.image = UIImage(named: unwrappedUploadCell.imageName)
            let formattedText = AttributedStringHelper.getString(text: unwrappedUploadCell.name, fontType: .regular, size: 17, color: .black)
            messageLabel.attributedText = formattedText
        }
    }
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imv = UIImageView(frame: CGRect(x: 35, y: 35, width: 19, height: 26))
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        backgroundColor = .white
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [messageLabel, imageView].forEach {
            addSubview($0)
            $0.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        }
        messageLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 90), size: .init(width: 124, height: 20))
        
        imageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 140, bottom: 0, right: 0), size: .init(width: 20, height: 26))
    }
}
