//
//  CameraCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/15/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class CameraCell: FeedCell {
    
    private let cameraView: CameraView = {
        let view = CameraView(frame: UIScreen.main.bounds)
        return view
    }()
    override func setupViews() {
        addSubview(cameraView)
    }
   
}
