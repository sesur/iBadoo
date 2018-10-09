//
//  CollectionViewControllerGenerics.swift
//  iBadoo
//
//  Created by Sergiu on 8/14/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class BaseCollectionViewController<T: BasicCollectionCell<S>, S>: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var items = [S]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView?.backgroundColor = .white
        
        collectionView?.register(T.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BasicCollectionCell<S>
        
        cell.cellItem = items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

class BasicCollectionCell<U>: UICollectionViewCell {
    
    var cellItem: U!
   
}
struct Cat {
    let name: String
}

class CatCell: BasicCollectionCell<Cat> {
 
    let myLabelText: UILabel = {
        let label = UILabel()
        return label
    }()
 
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        addSubview(myLabelText)
        myLabelText.fillSuperView()
    }
    override var cellItem: Cat! {
        didSet {
            myLabelText.text = cellItem.name
        }
    }

}
class SomeController: BaseCollectionViewController<CatCell, Cat> {
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [Cat(name: "Miauuuuu"),
                 Cat(name: "Brrrrrrrr"),
                 Cat(name: "Hrrrrr")]
    }
}
