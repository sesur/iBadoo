//
//  HobbyTagsCollecetion.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/17/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import TagListView

class HobbyTagsCollection: BaseUIView, TagListViewDelegate {
    
//    private weak var hobbyTagListView: TagListView!
    
    private var hobbyTagListView: TagListView = {
        let hobby = TagListView(frame: CGRect(x: 0, y: 0, width: 300, height: 400)) // TagListView() //
        hobby.textFont = UIFont.systemFont(ofSize: 15)
        hobby.textColor = .mainBlue
        hobby.tagBackgroundColor = .white
        hobby.borderWidth = 1
        hobby.borderColor = .mainBlue
        hobby.cornerRadius = 5
        
        hobby.marginX = 10
        hobby.marginY = 15
        
        hobby.paddingX = 10
        hobby.paddingY = 8
        
        hobby.isMultipleTouchEnabled = true
        hobby.enableRemoveButton = false
        hobby.removeIconLineColor = .white
        hobby.removeIconLineWidth = 1
        
        return hobby
    }()
    
    override func setupViews() {
        super.setupViews()
        setupTags()
    }
    
    
    private var tagArray = ["Moview", "Girls", "Guys", "Boyfriend", "MakeFriends", "mamdc", "teste", "test", "mamdc", "teste", "test", "mamdc"]
    
    
    private func setupTags() {
        addSubview(hobbyTagListView)
        hobbyTagListView.delegate = self
        hobbyTagListView.addTags(tagArray)
        hobbyTagListView.alignment = .left
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title)")
        tagView.isSelected = !tagView.isSelected
        tagView.tagBackgroundColor = tagView.isSelected ? .mainBlue : .white
        layoutSubviews()
    }
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Removed tag: \(title)")
        sender.removeTagView(tagView)
    }
}























