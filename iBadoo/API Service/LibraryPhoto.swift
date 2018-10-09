//
//  LibraryPhoto.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/18/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit
import Photos


class LibraryPhoto: NSObject {
    static let instance = LibraryPhoto()
    
    func fetchImages(completion: @escaping ([Image]) -> ()){
        
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        var imageArray = [Image]()
        
        if fetchResult.count > 0 {
            for i in 0..<fetchResult.count {
                imageManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 120, height: 120), contentMode: .aspectFill, options: requestOptions, resultHandler: { image, _ in
                    
                    if let img = image {
                        let image = Image(imageThumbNails: img)
                        imageArray.append(image)
                    }
                })
                DispatchQueue.main.async {
                    completion(imageArray)
                }
                
            }
        } else {
            print("You do not have any photo")
        }
        
    }
    
    
}
