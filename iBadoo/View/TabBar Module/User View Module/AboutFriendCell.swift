//
//  AboutFriendCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/27/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class UserInfoCell: FeedCell {

    private let aboutFriendView: UserInfoView = {
        let view = UserInfoView()
        return view
    }()
    override func setupViews() {
        addSubview(aboutFriendView)
        aboutFriendView.fillSuperView()
    }
}
