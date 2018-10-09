//
//  LibraryCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/15/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class LibraryCell: BaseCell {
    
    var libraryImageObserver: Image? {
        didSet{
            guard let unwrappedLibraryCell = libraryImageObserver else { return }
            imageView.image = unwrappedLibraryCell.imageThumbNails
        }
    }
    private var imageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    private var transparentView: BaseUIView = {
        let transparentView = BaseUIView()
        return transparentView
    }()
    private let checkImage: UIImageView = {
        let checkImv = UIImageView()
        return checkImv
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        [imageView, transparentView, ].forEach{ addSubview($0) }
        imageView.fillSuperView()
        transparentView.fillSuperView()
        
        [checkImage].forEach {transparentView.addSubview($0)}
        checkImage.anchorCenter(vertical: centerYAnchor, horizontal: centerXAnchor)
        checkImage.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .zero, size: .init(width: 42, height: 42))
    }
    
    //MARK:- Actions
    private func setselectedState() {
        if self.isSelected {
            UIView.animate(withDuration: 0.35) {
                self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.transparentView.backgroundColor = #colorLiteral(red: 0.04790695012, green: 0.3381513953, blue: 0.9071245193, alpha: 0.8965669014)
                self.checkImage.image = UIImage(named: "check")
            }
        } else {
            UIView.animate(withDuration: 0.35) {
                self.imageView.transform = .identity
                self.transparentView.backgroundColor =  .clear
                self.checkImage.image = UIImage(named: "nil")
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            setselectedState()
        }
    }
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                UIView.animate(withDuration: 0.35) {
                    self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    self.transparentView.backgroundColor = #colorLiteral(red: 0.04790695012, green: 0.3381513953, blue: 0.9071245193, alpha: 0.8965669014)
                    self.checkImage.image = UIImage(named: "check")
                }
            } else {
                UIView.animate(withDuration: 0.35) {
                    self.imageView.transform = .identity
                    self.transparentView.backgroundColor =  .clear
                    self.checkImage.image = UIImage(named: "nil")
                }
            }
        }
    }
}























