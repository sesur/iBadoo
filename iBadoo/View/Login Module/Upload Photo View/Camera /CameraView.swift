//
//  CameraView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/15/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class CameraView: BaseUIView {
    
    private let cameraImageView: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "bitmap")
        return imageView
    }()
    
    override func setupViews() {
        addSubview(cameraImageView)
    }
}
