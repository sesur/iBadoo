//
//  HobbiesCollectionTagView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/2/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

struct Tags {
    let textName: String?
    let imageName: String?
}

class HobbiesCollectionTagView: BaseUIView,  UICollectionViewDelegate {
    
    private let cellId = "cellTagId"
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(TagCell.self, forCellWithReuseIdentifier: cellId)
        return collection
    }()
    
    private var hobbyTagsArray : [Tags] = {
        let hobby = [Tags(textName: "Movie", imageName: nil),
                     Tags(textName: "Tennis", imageName: nil),
                     Tags(textName: "Girls", imageName: nil),
                     Tags(textName: "Guys", imageName: nil),
                     Tags(textName: "Boyfriend", imageName: nil)]
        return hobby
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        setupLayouts()
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        addSubview(collectionView)
        collectionView.fillSuperView()
    }
}

extension HobbiesCollectionTagView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hobbyTagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TagCell
        cell.collectionTagObserver = hobbyTagsArray[indexPath.item]
        return cell
    }
}


extension HobbiesCollectionTagView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height: CGFloat = 36
        var width: CGFloat = 100
        
        if let text = hobbyTagsArray[indexPath.item].textName {
//           width = estimateFrameFor(text: text).width + 20
            width = sizeOfString(string: text, constrainedToWidth: Double(width)).width + 25
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




