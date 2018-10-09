//
//  ChatInputContainerView.swift
//  iBadoo
//
//  Created by Sergiu on 9/10/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class ChatInputContainerView: UIView  {
    
    var chatLogController: ChatLogViewController? {
        didSet {
            sendButton.addTarget(chatLogController, action: #selector(ChatLogViewController.handleSendButtonTap), for: .touchUpInside)
        }
    }
    
    
    //MARK:- Lazy vars
    lazy var sendMessageTextView: UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: 17)
        text.textColor = .lightGray
        //        text.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 14)
        text.textContainerInset = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: -5)
        text.textContainer.lineFragmentPadding = 14
        text.text = PLACEHOLDER_TEXT
        text.layer.borderColor = #colorLiteral(red: 0.7453632951, green: 0.7963940501, blue: 0.8933854699, alpha: 1)
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 15
        text.layer.masksToBounds = true
        text.autocorrectionType = .no
        text.delegate = self
        text.selectedTextRange = text.textRange(from: text.beginningOfDocument, to: text.beginningOfDocument)
        return text
    }()

    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "send")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .mainBlue
        return button
    }()
    
    lazy var uploadImageView: UIImageView = {
        let uploadImageView = UIImageView()
        uploadImageView.isUserInteractionEnabled = true
        uploadImageView.translatesAutoresizingMaskIntoConstraints = false
        uploadImageView.contentMode = .scaleAspectFit
        uploadImageView.image = UIImage(named: "photos")?.withRenderingMode(.alwaysTemplate)
        uploadImageView.tintColor = .separatorColor
        //        uploadImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUploadTap)))
        return uploadImageView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayouts(){
        let topBorderView = UIView()
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        topBorderView.backgroundColor = .separatorColor
        
        [uploadImageView, sendMessageTextView, sendButton, topBorderView].forEach { addSubview($0) }
        
        uploadImageView.anchor(top: sendMessageTextView.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: imageHeight, height: imageHeight))
//        uploadImageView.anchorCenter(vertical: centerYAnchor, horizontal: nil)
        
        sendMessageTextView.anchor(top: topAnchor, leading: uploadImageView.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 48), size: .zero)
        
        sendButton.anchor(top: sendMessageTextView.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8), size: .init(width: 35, height: 35))
        
        topBorderView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 1, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
    }
}




extension ChatInputContainerView: UITextViewDelegate {
    
    
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let currentText = textView.text as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: text)

            if updatedText.isEmpty {
                applyPlaceholderStyle(textView: textView)
                return false
            } else if textView.textColor == .lightGray && !textView.text.isEmpty {
                applyNonPlaceholder(textView: textView)
            }
            if text == NEW_LINE {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    
        internal func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                applyPlaceholderStyle(textView: textView)
                chatLogController?.saveMessageInFirebase()
            }
        }
        func textViewDidChangeSelection(_ textView: UITextView) {
            if self.window != nil {
                if textView.textColor == .lightGray {
                    textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
                }
            }
            
        }
//
////        self.window != nil,

   // MARK:- HelperMethods
        func applyPlaceholderStyle(textView: UITextView){
            textView.text = PLACEHOLDER_TEXT
            textView.textColor = .lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        func applyNonPlaceholder(textView: UITextView){
            textView.textColor = .black
            textView.text = nil
        }
}


