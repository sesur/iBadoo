//
//  UserPictureDetailsCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 4/6/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserPictureDetailsCell: BaseCell {
    
    var libraryImageObserver: Image? {
        didSet{
            guard let unwrappedLibraryCell = libraryImageObserver else { return }
            imageView.image = unwrappedLibraryCell.imageThumbNails
//            numberOfphotosLabel.text = unwrappedLibraryCell.photoNumbers
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.contentScaleFactor = 3
        return imageView
    }()
    
 
    //MARK:- Layouts
    override func setupViews() {
        setupLayouts()
    }
    
    //MARK:- Life Cycle
    private func setupLayouts() {
        [imageView].forEach { addSubview($0) }
        imageView.fillSuperView()
    }
}
