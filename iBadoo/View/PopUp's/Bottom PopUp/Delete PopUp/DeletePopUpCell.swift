//
//  DeletePopUpCell.swift
//  iBadoo
//
//  Created by Sergiu on 5/8/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class DeletePopUpCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = self.isHighlighted ? #colorLiteral(red: 1, green: 0.4227682847, blue: 0.3761387531, alpha: 0.5) : #colorLiteral(red: 1, green: 0.4227682847, blue: 0.3761387531, alpha: 0.8981967038)
        }
    }
     var deleteObserver: PopUpModel? {
        didSet {
            guard let unwrappedDeleteCell = deleteObserver else { return }
            
            imageView.image = UIImage(named: unwrappedDeleteCell.imageName)
            let formattedText = AttributedStringHelper.getString(text: unwrappedDeleteCell.name, fontType: .regular, size: 17, color: .white)
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
