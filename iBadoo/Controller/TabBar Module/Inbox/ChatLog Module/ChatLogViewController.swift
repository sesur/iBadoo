//
//  ChatLogViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/7/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData
import Firebase


class ChatLogViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    private let cellId = "cellId"
    private var bottomConstraint: NSLayoutConstraint?
    
    //    private let messageContainerView: UIView = {
    //        let container = UIView()
    //        container.backgroundColor = .white
    //        return container
    //    }()
    
    var user: CurrentUser? {
        didSet {
            navigationItem.title = user?.fullName
            self.observeUserMessages()
        }
    }
    var messagesArray = [CurrentMessages]()
    
    //MARK:- Fetch user message
    private func observeUserMessages() {
        
        guard let uid = Auth.auth().currentUser?.uid, let toId = user?.id else {return}
        
        Database.database().reference().child("user-messages").child(uid).observe(.childAdded, with: { (snapshot) in
            let userId = snapshot.key
            Database.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
                let messageId = snapshot.key
                Database.database().reference().child("messages").child(messageId).observeSingleEvent(of: .value, with: { (snapshot) in
//                    print(snapshot)
                    // from here
                                guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
                                let message = CurrentMessages(dictionaryValues: dictionary)
                                //
                                //            if message.chatPartnerId() == message.fromId {
                                //, let toId = user?.id
                    //            print(self.user?.id )
                    
                    if message.chatPartnerId() == self.user?.id  {
                                    self.messagesArray.append(message)
                                    DispatchQueue.global(qos: .userInteractive).async {
                                        DispatchQueue.main.async(execute: {
                                            self.collectionView?.reloadData()
                                            let indexPath = IndexPath(item: self.messagesArray.count - 1 , section: 0)
                                            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                                        })
                                    }
                                }
                    // till here
                }, withCancel: nil)

            }, withCancel: nil)

        }, withCancel: nil)
        
//        Database.database().reference().child("messages").observe(.childAdded, with: { (snapshot) in
//            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
//            let message = CurrentMessages(dictionaryValues: dictionary)
////
////            if message.chatPartnerId() == message.fromId {
//            //, let toId = user?.id
//            print(self.user?.id )
//
//            if message.chatPartnerId() == self.user?.id || message.chatPartnerId() == message.fromId {
//
//                self.messagesArray.append(message)
//                DispatchQueue.global(qos: .userInteractive).async {
//                    DispatchQueue.main.async(execute: {
//                        self.collectionView?.reloadData()
//                        let indexPath = IndexPath(item: self.messagesArray.count - 1 , section: 0)
//                        self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
//                    })
//                }
//            }
//
//        }, withCancel: nil)
        
        
        
//        guard let uid = Auth.auth().currentUser?.uid, let toId = user?.id else {return}
//       Database.database().reference().child("user-messages").child(uid).child(toId).observe(.childAdded, with: { (snapshot) in
//            print(snapshot.key)
//            let messageId = snapshot.key
//            self.fetchUserMessageWith(messageId: messageId)
//        }, withCancel: nil)
    }
    
    private func fetchUserMessageWith(messageId: String) {
        let messagesReference = Database.database().reference().child("messages").child(messageId)
        messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let message = CurrentMessages(dictionaryValues: dictionary)
            self.messagesArray.append(message)
            DispatchQueue.global(qos: .userInteractive).async {
                DispatchQueue.main.async(execute: {
                    self.collectionView?.reloadData()
                    let indexPath = IndexPath(item: self.messagesArray.count - 1 , section: 0)
                    self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                })
            }
            
        }, withCancel: nil)
    }
    
    
    //MARK:- NSFetchedResultsController
    //    lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<NSFetchRequestResult> in
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
    //        fetchedRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
    //        fetchedRequest.predicate = NSPredicate(format: "userR.name = %@", self.user!.name!)
    //        let context = appDelegate.persistentContainer.viewContext
    //        let frc = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    //        frc.delegate = self
    //        return frc
    //    }()
    
    var blockOperations = [BlockOperation]()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            blockOperations.append(BlockOperation(block: {
                self.collectionView?.insertItems(at: [newIndexPath!])
            }))
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            blockOperations.forEach {$0.start()}
        }, completion: { (completed) in
            //            let lastItem = self.fetchedResultsController.sections![0].numberOfObjects - 1
            //            let indexPath = IndexPath(item: lastItem, section: 0)
            //            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        })
    }
    
    
    
    
    
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        
        //        do {
        //            try fetchedResultsController.performFetch()
        //           // print(fetchedResultsController.sections![0].numberOfObjects)
        //        } catch let err {
        //            debugPrint("Couldn't fetche due \(err.localizedDescription)")
        //        }
        
        //        setupMessageContainerLayouts()
        
        
        setupKeyboardObserverNotifications()
        setupCollectionView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
        
    }
    
    lazy var inputContainerView: ChatInputContainerView = {
        let chatInputContainerView = ChatInputContainerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 54))
        chatInputContainerView.chatLogController = self
        return chatInputContainerView
    }()
    
    
    override var inputAccessoryView: UIView? {
        return inputContainerView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideNavigationTabBar(true)
        IQKeyboardManager.shared.enable = false
        setupNavigation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideNavigationTabBar(false)
        
    }
    
    //MARK:- Setup CollectionView
    private func setupCollectionView() {
        collectionView?.backgroundColor = #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
        collectionView?.register(ChatLogCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
//        collectionView?.contentMode
        
        collectionView?.keyboardDismissMode = .interactive
    }
    
    //Setup Navigation Controller
    private func setupNavigation() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = .mainBlue
        navigationController?.navigationBar.tintColor = .white
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "more"), style: .done, target: self, action: #selector(handleMoreButtonTap)),
                                              UIBarButtonItem(title: "simulate", style: .done, target: self, action: #selector(handleSimulateButtonTap))
        ]
    }
    
    
    
    
    //MARK:- Layouts
    
    
    
    //    private func setupMessageContainerLayouts() {
    //        view.addSubview(messageContainerView)
    //        messageContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size:.init(width: 0, height: 65))
    //
    //        bottomConstraint = NSLayoutConstraint(item: messageContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    //        view.addConstraint(bottomConstraint!)
    //        setupContainerComponentsLayout()
    //    }
    //    private func setupContainerComponentsLayout() {
    //        let topBorderView = UIView()
    //        topBorderView.backgroundColor = #colorLiteral(red: 0.7453632951, green: 0.7963940501, blue: 0.8933854699, alpha: 1)
    //
    //        [sendMessageTextView, sendButton, topBorderView].forEach { messageContainerView.addSubview($0) }
    //        sendMessageTextView.anchor(top: messageContainerView.topAnchor, leading: messageContainerView.leadingAnchor, bottom: messageContainerView.bottomAnchor, trailing: messageContainerView.trailingAnchor, padding: .init(top: 10, left: 25, bottom: 10, right: 48), size: .zero)
    //
    //        sendButton.anchor(top: sendMessageTextView.topAnchor, leading: nil, bottom: nil, trailing: messageContainerView.trailingAnchor, padding: .init(top: 7, left: 0, bottom: 0, right: 8), size: .init(width: 35, height: 35))
    //
    //        topBorderView.anchor(top: messageContainerView.topAnchor, leading: messageContainerView.leadingAnchor, bottom: nil, trailing: messageContainerView.trailingAnchor, padding: .init(top: 1, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
    //    }
    
    
    
    //MARK:- Keyboard Notifications
    private func setupKeyboardObserverNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMessageTap), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMessageTap), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardTap), name: .UIKeyboardWillShow, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardTap), name: .UIKeyboardWillHide, object: nil)
    }
    
    
    @objc private func handleMessageTap() {
        if self.messagesArray.count > 0 {
                            let indexPth = IndexPath(item: self.messagesArray.count - 1 , section: 0)
                            self.collectionView?.scrollToItem(at: indexPth, at: .bottom, animated: true)
                            self.collectionView?.layoutIfNeeded()
                        }
        
//        delay(time: 0.1) {
//            if self.messagesArray.count > 0 {
//                let indexPth = IndexPath(item: self.messagesArray.count - 1 , section: 0)
//                self.collectionView?.scrollToItem(at: indexPth, at: .bottom, animated: true)
//                self.collectionView?.layoutIfNeeded()
//            }
//        }
        
    }
    
    
    
    
    //MARK:- Actions
    @objc private func handleUploadTap() {
        let imagePickerController = PickerTestVC()
        navigationController?.pushViewController(imagePickerController, animated: true)
//        navigationController?.present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleSendButtonTap() {
        saveMessageInFirebase()
        applayPlaceholder()
    }
    
    func saveMessageInFirebase() {
        guard let message = inputContainerView.sendMessageTextView.text else {return}
        if !message.isEmpty && message != PLACEHOLDER_TEXT {
            sendUser(message)
        }
        
    }
    
    private func sendUser(_ message: String) {
        //        let properties: [String: Any] = ["message" : sendMessageTextView.text,"fullName": fullName , "toId": toId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
        
        let properties: [String: Any] = ["message" : message] as [String : Any]
        sendMessageWith(properties: properties)
    }
    
    private func sendMessageWith(properties: [String: Any]) {
        
        guard let toId = user?.id else {return}
        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
        guard let fromId: String = Auth.auth().currentUser?.uid else {return}
        
        let childRef = Database.database().reference().child("messages").childByAutoId()
        var values:[String: Any] = ["toId": toId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
         properties.forEach({values[$0] = $1})
        
        childRef.setValue(values) { (error, reference) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }

            let senderMessageRef = Database.database().reference().child("user-messages").child(fromId).child(toId)
            let messageId = childRef.key
            senderMessageRef.setValue([messageId: true])

            let recipientMessageReference = Database.database().reference().child("user-messages").child(toId).child(fromId)
            recipientMessageReference.setValue([messageId: true])
        }
        
        
       
//
//        childRef.updateChildValues(values) { (error, ref) in
//            if error != nil {
//                print(error?.localizedDescription as Any)
//                return
//            }
//
//            //sender reference
//            let userMessagesRef = Database.database().reference(withPath: "user-messages").child(fromId).child(toId)
//            let messagesId = childRef.key
//            userMessagesRef.updateChildValues([messagesId: 1])
//
//            //recipient reference
//            let recipientUserMessageReference = Database.database().reference().child("user-messages").child(toId).child(fromId)
//            recipientUserMessageReference.updateChildValues([messagesId: 1])
//        }
        
    }
    
    private func applayPlaceholder() {
        guard let sendMessage = self.inputContainerView.sendMessageTextView.text  else {return}
        if !sendMessage.isEmpty && sendMessage != PLACEHOLDER_TEXT {
            self.inputContainerView.sendMessageTextView.text = nil
            if self.inputContainerView.sendMessageTextView.text.isEmpty {
                self.inputContainerView.applyPlaceholderStyle(textView: self.inputContainerView.sendMessageTextView)
            }
        }
    }
    
    
    //    @objc private func handleSendButtonTap() {
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //        let context = appDelegate.persistentContainer.viewContext
    //
    //        guard let sendMessage = sendMessageTextView.text  else {return}
    //
//            if !sendMessage.isEmpty && sendMessage != PLACEHOLDER_TEXT {
//                let filtteredText = sendMessage.trimmingCharacters(in: .whitespacesAndNewlines)
//                InboxView.createMessageWith(text: filtteredText, user: user!, minutesAgo: 0, context: context, isSender: true)
//                sendMessageTextView.text = nil
//                if sendMessageTextView.text.isEmpty {
//                    applyPlaceholderStyle(textView: sendMessageTextView)
//                }
//            }
    //        do {
    //            try context.save()
    //        } catch let err {
    //            debugPrint("Couldn't save due error \(err.localizedDescription)")
    //        }
    //    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //    @objc private func handleKeyboardTap(notification: NSNotification) {
    //        if let userInfo = notification.userInfo {
    //            guard let keyboardFrameSize = ((userInfo[UIKeyboardFrameBeginUserInfoKey]) as AnyObject).cgRectValue else {return}
    //            let keyboadDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
    //
    //            let isKeyboardShowing = notification.name == .UIKeyboardWillShow
    //            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrameSize.height : 0
    //
    //            UIView.animate(withDuration: keyboadDuration!, delay: 0, options: .curveEaseOut, animations: {
    //                self.view.layoutIfNeeded()
    //            }, completion: { (completed) in
    //                if isKeyboardShowing {
    //                    //                    let lastItem = self.fetchedResultsController.sections![0].numberOfObjects - 1
    //                                        let lastItem = self.messagesArray.count - 1
    //                                        let indexPath = IndexPath(item: lastItem, section: 0)
    //                                        self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
    //                }
    //            })
    //        }
    //    }
    
    
    @objc private func handleSimulateButtonTap(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //        InboxView.createMessageWith(text: "A text message was sent few minutes ago ... ", user: user!, minutesAgo: 1, context: context)
        //        InboxView.createMessageWith(text: "Another message received a while ago ...  ", user: user!, minutesAgo: 1, context: context)
        do {
            try context.save()
        } catch let err {
            debugPrint("Couldn't fetch due: \(err.localizedDescription)")
        }
    }
    
    
    //MARK:- Navigation
    @objc private func handleMoreButtonTap() {
        let friendProfileVC = UserProfileViewController()
        navigationController?.pushViewController(friendProfileVC, animated: true)
    }
}


extension ChatLogViewController {
    
    //MARK:- Datasource & Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        if let count = fetchedResultsController.sections?[0].numberOfObjects {
        //            return count
        //        }
        return messagesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogCell
        let message = messagesArray[indexPath.row]
        cell.chatMesage = message
        setupCell(cell, message)
        cell.bubbleWidthAnchor?.constant = estimateFrame(forText: message.message!).width + 32
        
  
        
        //        cell.backgroundColor = .yellow
        
        //        let message = fetchedResultsController.object(at: indexPath) as! Message
        
        //        if let messageText = message.text, let profileImageName = message.userR?.profileImageName  {
        //            cell.chatMesage = messageText
        //            cell.profileImageView.image = UIImage(named: profileImageName)
        //
        //            let size = CGSize(width: 250, height: 1000)
        //            let options = NSStringDrawingOptions.usesLineFragmentOrigin
        //            let estimateFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)], context: nil)
        //
        //            if !message.isSender {
        //                cell.messageTextView.frame = CGRect(x: 65 + 8 + 16 + 8, y: 0, width: estimateFrame.width + 16 + 4, height: estimateFrame.height + 20)
        //                cell.bubbleView.frame = CGRect(x: 65 + 8, y: 0, width: estimateFrame.width + 16 + 28 + 8, height: estimateFrame.height + 20)
        //                cell.profileImageView.isHidden = false
        //                cell.bubbleImageView.image = ChatLogCell.grayBubbleImage
        //                cell.bubbleImageView.tintColor = #colorLiteral(red: 0.8961514831, green: 0.9179288745, blue: 0.9744198918, alpha: 1)
        //                cell.messageTextView.textColor = .black
        //
        //            } else  {
        //                cell.messageTextView.frame = CGRect(x: view.frame.width - estimateFrame.width - 16 - 16, y: 0, width: estimateFrame.width + 16 , height: estimateFrame.height + 20)
        //                cell.bubbleView.frame = CGRect(x: view.frame.width - estimateFrame.width - 16 - 20 - 4, y: 0, width: estimateFrame.width + 16 + 16, height: estimateFrame.height + 20)
        //                cell.profileImageView.isHidden = true
        //                cell.bubbleImageView.image = ChatLogCell.blueBubbleImage
        //                cell.bubbleImageView.tintColor = .mainBlue
        //                cell.messageTextView.textColor = .white
        //            }
        //        }
        return cell
    }
    
    private func setupCell(_ cell: ChatLogCell, _ message: CurrentMessages) {
        guard let profileImageUrl = user?.profilePictureUrl  else {return}
        
        cell.profileImageView.loadImageUsingCacheWith(profileImageUrl)
        
        if message.fromId == Auth.auth().currentUser?.uid {
            // outgoing blue cell
            cell.bubbleView.backgroundColor = .mainBlue
            cell.messageTextView.textColor = .white
            
            cell.profileImageView.isHidden = true
            cell.bubbleTrailingAnchor?.isActive = true
            cell.bubbleLeadingAnchor?.isActive = false
            
        } else {
            // incoming gray cell
            cell.bubbleView.backgroundColor = .separatorColor
            cell.messageTextView.textColor = .black
            
            cell.profileImageView.isHidden = false
            cell.bubbleTrailingAnchor?.isActive = false
            cell.bubbleLeadingAnchor?.isActive = true
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputContainerView.sendMessageTextView.endEditing(true)
    }
    
    //MARK:- Helper Methods
    private func delay(time: TimeInterval, closure: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: closure)
    }
}
