//
//  LanguageCollectionTagView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/19/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class LanguageCollectionTagView: BaseUIView,  UICollectionViewDelegate {
    
    private let cellId = "cellTagId"
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(TagCell.self, forCellWithReuseIdentifier: cellId)
        return collection
    }()
    
    var languageTagsArray : [Tags] = {
        let hobby = [Tags(textName: "Romanian", imageName: nil),
                     Tags(textName: "English", imageName: nil),
                     Tags(textName: "Russian", imageName: nil),
                     Tags(textName: "French", imageName: nil),
                     Tags(textName: "Chinesse", imageName: nil),
                     Tags(textName: "Spanish", imageName: nil),
                     Tags(textName: "Italian", imageName: nil)
                     ]
        return hobby
    }()
    
    override func setupViews() {
        setupCollcetionViewLayouts()
    }
    
    private func setupCollcetionViewLayouts() {
        addSubview(collectionView)
        collectionView.fillSuperView()
    }
    
}



extension LanguageCollectionTagView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languageTagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TagCell
        cell.collectionTagObserver = languageTagsArray[indexPath.item]
        return cell
    }
}


extension LanguageCollectionTagView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 33
        var width: CGFloat = 100
        
        if let text = languageTagsArray[indexPath.item].textName {
            //           width = estimateFrameFor(text: text).width + 20
            width = sizeOfString(string: text, constrainedToWidth: Double(width)).width + 21
        }
        
        
        return CGSize(width: width, height: height)
    }
    
    private func estimateFrameFor(text: String) -> CGSize {
        let size = CGSize(width: Double.greatestFiniteMagnitude, height: 30)
        return  NSString(string: text).boundingRect(with: size,
                                                    options: .usesLineFragmentOrigin,
                                                    attributes: [.font: self],
                                                    context: nil).size
    }
    
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        let attString = NSAttributedString(string: string,attributes: nil)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: width, height: .greatestFiniteMagnitude), nil)
    }
    
}
