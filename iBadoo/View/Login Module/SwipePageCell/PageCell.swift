//
//  PageCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/4/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

class PageCell: BaseCell {
    
    var pageCellObserver: Page? {
        didSet {
            guard let unwrappedPageCell = pageCellObserver else { return }
            swipeImageView.image = UIImage(named: unwrappedPageCell.imageName)
            headerTextView.attributedText = AttributedStringHelper.getString(text: unwrappedPageCell.headerText, fontType: .regular, size: 28, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
            headerTextView.textAlignment = .center
            bodyTextView.attributedText = AttributedStringHelper.getString(text: unwrappedPageCell.bodyText, fontType: .regular, size: 17, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
            bodyTextView.textAlignment = .center
        }
    }
    
    private var headerTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.sizeToFit()
        return textView
    }()
    
    private var swipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.sizeToFit()
        textView.backgroundColor = .clear
        return textView
    }()
    
    override func setupViews() {
         setupLayouts()
    }
    
    private func setupLayouts() {
        let stack = UIStackView(arrangedSubviews: [swipeImageView])
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .fill
        
        [headerTextView, stack, bodyTextView].forEach {addSubview($0)}
        
        headerTextView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 55, left: 35, bottom: 0, right: 35), size: .zero)
        
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 40, left: 35, bottom: 0, right: 35), size: .zero)

        bodyTextView.anchor(top: nil, leading: stack.leadingAnchor, bottom: stack.bottomAnchor, trailing: stack.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0), size: .zero)
    }
    
    
//    func textViewResize(to textView: UITextView)
//    {
//        let newSize = textView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
//        textView.frame = CGRect(origin: textView.frame.origin, size: newSize)
//        
//    }
}
