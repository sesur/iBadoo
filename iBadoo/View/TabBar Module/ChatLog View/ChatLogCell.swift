//
//  ChatLogCell.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/7/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit



class ChatLogCell: BaseCell {
    
    
    
    var chatMesage: CurrentMessages? {
        didSet {
            guard let unwrappedMessage = chatMesage else {return}
            guard let message = unwrappedMessage.message else {return}
            messageTextView.text = message
        }
    }
    
    let messageTextView: UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: 18)
        text.backgroundColor = .clear
        text.textColor = .white
        text.isEditable = false
        text.isScrollEnabled = false
        return text
    }()
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hariton")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageHeight / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    static let grayBubbleImage = UIImage(named: "left_tail")?.resizableImage(withCapInsets: UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)).withRenderingMode(.alwaysTemplate)
//    static let blueBubbleImage = UIImage(named: "right_tail")?.resizableImage(withCapInsets: UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)).withRenderingMode(.alwaysTemplate)
    
//    let bubbleImageView: UIImageView = {
//        let bubble = UIImageView()
//        bubble.image = ChatLogCell.grayBubbleImage
//        bubble.tintColor = #colorLiteral(red: 0.8961514831, green: 0.9179288745, blue: 0.9744198918, alpha: 1)
//        return bubble
//    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
        backgroundColor = #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
        setupLayouts()
    }
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleTrailingAnchor: NSLayoutConstraint?
    var bubbleLeadingAnchor: NSLayoutConstraint?
    
    //MARK:- Layouts
    private func setupLayouts() {
        //bubbleView, , profileImageView
        [bubbleView, messageTextView, profileImageView].forEach { addSubview($0) }
        
        
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: imageHeight, height: imageHeight))
        
        
        
        
//        bubbleView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .zero)
        
        bubbleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        bubbleTrailingAnchor = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        bubbleTrailingAnchor?.isActive = true
        
        bubbleLeadingAnchor = bubbleView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8)
        
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        bubbleWidthAnchor?.isActive = true

        
        
        messageTextView.anchor(top: topAnchor, leading: bubbleView.leadingAnchor, bottom: bottomAnchor, trailing: bubbleView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8), size: .zero)
        
        
        
        
//        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 42, height: 42))
//
//        bubbleView.addSubview(bubbleImageView)
//        bubbleImageView.anchor(top: bubbleView.topAnchor, leading: bubbleView.leadingAnchor, bottom: bubbleView.bottomAnchor, trailing: bubbleView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
    }
}
