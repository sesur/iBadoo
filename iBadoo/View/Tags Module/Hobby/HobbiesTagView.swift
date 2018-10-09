//
//  HobbiesTagView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/4/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import TagListView
//import WSTagsField


enum Options: String{
    case comma = ","
    case space = " "
}

class HobbiesTagView: BaseUIView, BorderProtocol, RoundCornerProtocol {
    
  private var tagsArray: [String] = [ ]
    
   private var viewForTags: UIView = {
        let view = UIView()
        return view
    }()
    
    private let tagField: TagListView = {
        let tag = TagListView()
        tag.toolbarPlaceholder = MyProfile.Text.hobbyPlaceholder.rawValue
//        tag.placeholderText = MyProfile.Text.hobbyPlaceholder.rawValue
//        tag.
//        tag.delimiter = ""
//        tag.keyboardType = .default
//        tag.
        return tag
    }()
    
    override func setupViews() {
       super.setupViews()
        setupLayouts()
        
        tagEvents()
        addBorder(color: #colorLiteral(red: 0.762342751, green: 0.8078361154, blue: 0.8646178842, alpha: 1))
        addBorder(width: 1.0)
        addRoundCorner()

    }
    
    private func tagEvents() {
        // Events
        
//        tagField.onDidAddTag = { tag, text in
//     
//            print("DidAddTag")
//        }
//        
//        tagField.onDidRemoveTag = { tag, text in
//            
//            print("DidRemoveTag")
//        }
//        
//        tagField.onDidChangeText = { tag, text in
//            guard let unwrappedText = text else { return }
//            
//            if unwrappedText.contains(Options.comma.rawValue) || unwrappedText.contains(Options.space.rawValue) {
//                
//                if !unwrappedText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//                    let newText = unwrappedText.replacingOccurrences(of: Options.comma.rawValue, with: "").replacingOccurrences(of: Options.space.rawValue, with: "")
//                    
//                    if tag.tokenizeTextFieldText() != nil, !newText.isEmpty {
//                        self.tagField.removeTags()
//                        if self.tagsArray.contains(newText) {
//                            print("This tag already exists")
//                            self.tagField.removeTags()
//                        } else {
//                            self.tagField.addTag(newText)
//                            self.tagsArray.append(newText)
//                        }
//                        print(self.tagsArray)
//                    }
//                } else {
//                    print("Empty tag inserted")
//                    tag.text = nil
//                    self.tagField.removeTags()
//                }
//            }
//        }
//        
//        tagField.onDidBeginEditing = { tag in
//            print("DidBeginEditing")
//        }
//        
//        tagField.onDidEndEditing = { _ in
//            print("DidEndEditing")
//        }
//        
//        tagField.onDidChangeHeightTo = { sender, height in
//            print("HeightTo \(height)")
//        }
//        
//        tagField.onDidSelectTagView = { _, tagView in
//            print("Select \(tagView)")
//        }
//        
//        tagField.onDidUnselectTagView = { _, tagView in
//            print("Unselect \(tagView)")
//        }
    }
    
    private func setupLayouts() {
        [viewForTags].forEach { addSubview($0) }
        viewForTags.fillSuperView()
        
        [tagField].forEach { viewForTags.addSubview($0) }
        tagField.fillSuperView()
    }
    
}
