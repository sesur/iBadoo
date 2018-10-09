//
//  CashImages.swift
//  iBadoo
//
//  Created by Sergiu on 8/9/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()


extension UIImageView {
    func loadImageUsingCacheWith(_ urlString: String) {
        
        self.image = nil
        
        // check cache image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        // otherwise start a new download
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url )
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            DispatchQueue.global(qos: .userInteractive).async {
                DispatchQueue.main.async(execute: {
                    
                    if let downloadedImage  = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                        self.layoutSubviews()
                        self.layoutIfNeeded()
                    }
                }
                )}
            
            }.resume()
    }
}
