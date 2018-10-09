//
//  PopUpCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/20/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class UploadPopUpCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = self.isHighlighted ? #colorLiteral(red: 0.04790695012, green: 0.3381513953, blue: 0.9071245193, alpha: 0.7030974912) : #colorLiteral(red: 0.1098039216, green: 0.2745098039, blue: 0.8901960784, alpha: 0.9028245888)
        }
    }
    
    var uploadObserver: PopUpModel? {
        didSet {
            guard let unwrappedUploadCell = uploadObserver else { return }
            
            imageView.image = UIImage(named: unwrappedUploadCell.imageName)
            let formattedText = AttributedStringHelper.getString(text: unwrappedUploadCell.name, fontType: .regular, size: 17, color: .white)
            messageLabel.attributedText = formattedText
        }
    }
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    private let imageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        backgroundColor = .clear
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        let containerStack = UIStackView(arrangedSubviews: [imageView, messageLabel])
        [containerStack].forEach {addSubview($0)}
        [containerStack].forEach {
            $0.distribution = .fillProportionally
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.spacing = 20
        }
        containerStack.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .zero, size: .init(width: 0, height: 30))
        containerStack.anchorCenter(vertical: centerYAnchor, horizontal: centerXAnchor)
    }
}
