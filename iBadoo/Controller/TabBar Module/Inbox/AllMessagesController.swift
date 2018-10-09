//
//  AllMessagesController.swift
//  iBadoo
//
//  Created by Sergiu on 8/28/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import Firebase


protocol InboxMessageDelegate: class {
    func push(viewcontroller: UIViewController, withUser: CurrentUser)
    func push()
}


class AllMessagesController: UICollectionViewController {
    
    let cellId = "cellId"
    
    var user: CurrentUser?
    let dbReference = Database.database().reference()
    
    var completionHandler: (() -> ())?
    
    var messageGroupID: String = "aschvasgc" {
        didSet {
            //            messageArray.first
            //            self.present(UIViewController(), animated: true, completion: nil)
            //            self.navigationController?.pushViewController(UIViewController(), animated: true)
            //            self.delegate?.push(viewcontroller: self, withUser: messageArray.first!)
        }
    }
    
    weak var delegate: InboxMessageDelegate?
    var messageArray: [CurrentMessages] = []
    var messageDictionary = [String: CurrentMessages]()
    
    
    //MARK:- Fetch messages
    func obserUserMessages() {
        
//        guard let uid = Auth.auth().currentUser?.uid else {return}
        
//        Database.database().reference().child("user-messages").child(uid).observeSingleEvent(of: .childAdded, with: { (snapshot) in
//            let userId = snapshot.key
//
//            DispatchQueue.global(qos: .userInitiated).async(execute: {
//                DispatchQueue.main.async(execute: {
//                    Database.database().reference().child("user-messages").child(uid).child(userId).observe(.value, with: { (snap) in
////                        print(snap.key)
//
//                        guard let messageId = snap.value as? [String: AnyObject] else {return}
//                        let key = Array(messageId)[0].key
//                        //                print(key)
//
//                        Database.database().reference().child("messages").observe(.value, with: { (snapshot) in
//                            print(snapshot)
//
//                            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
//                            let message = CurrentMessages(dictionaryValues: dictionary)
//                            //
//                            if let chatPartnerId = message.chatPartnerId() {
//                                self.messageArray.append(message)
//
//                                self.messageDictionary[chatPartnerId] = message
//                                self.messageArray = Array(self.messageDictionary.values)
//
//                                DispatchQueue.global(qos: .userInteractive).async(execute: {
//                                    DispatchQueue.main.async(execute: {
//                                        print("we reloaded the data")
//                                        self.collectionView?.reloadData()
//                                    })
//                                })
//                                //                    }
//                            }
//
//                        }, withCancel: nil)
//                    }, withCancel: nil)
//                })
//            })
//
//
//
//        }, withCancel: nil)
//
        
        
    /*
        Database.database().reference().child("user-messages").child(uid).observe(.childAdded, with: { (snapshot) in
            let userId = snapshot.key
            print(userId)
            
            Database.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
                let messageId = snapshot.key
                Database.database().reference().child("messages").child(messageId).observeSingleEvent(of: .value, with: { (snapshot) in
                    print(snapshot)
                    // from here
                    guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
                    let message = CurrentMessages(dictionaryValues: dictionary)
      /*
                    if let chatPartnerId = message.chatPartnerId() {
                        self.messageDictionary[chatPartnerId] = message
                        print(message.message)
                        //
                        self.messageArray = Array(self.messageDictionary.values)
                        self.sortMessages()
                        DispatchQueue.global(qos: .userInteractive).async(execute: {
                            DispatchQueue.main.async(execute: {
                                print("we reloaded the data")
                                self.collectionView?.reloadData()
                            })
                        })
                        
//                        self.attemptReloadCollecion()
                    }
     */
                    
                    
                    //
                    //            if message.chatPartnerId() == message.fromId {
                    //, let toId = user?.id
                    //            print(self.user?.id )
                    
//                    if message.chatPartnerId() == self.user?.id  {
//                        self.messagesArray.append(message)
//                        DispatchQueue.global(qos: .userInteractive).async {
//                            DispatchQueue.main.async(execute: {
//                                self.collectionView?.reloadData()
//                                let indexPath = IndexPath(item: self.messagesArray.count - 1 , section: 0)
//                                self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
//                            })
//                        }
//                    }
                    // till here
                }, withCancel: nil)
                
            }, withCancel: nil)
            
        }, withCancel: nil)
  */
        
        
        
       // staring from here
        //        guard let uid = Auth.auth().currentUser?.uid else {return}
        dbReference.child("messages").observe(.childAdded, with: { (snapshot) in
            guard let dictionaryValue = snapshot.value as? [String: Any] else {return}
//            print(snapshot.value)
            let message = CurrentMessages(dictionaryValues: dictionaryValue)
            guard let chatPartnerId = message.chatPartnerId() else {return}
            self.messageDictionary[chatPartnerId] = message

            self.attemptReloadCollecion()
            //            self.fetchMessages()
        }, withCancel: nil)
        /// here is  the lasta code
        
        
        
        
        // .childAdded
        //        Database.database().reference().child("messages").child(uid).observe(.childAdded, with: { (snapshot) in
        //            let userId = snapshot.key                                                      // .childAdded
        //            Database.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
        ////                print(snapshot)
        //
        //                let messageId = snapshot.key
        //                self.fetchMessageWith(messageId: messageId)
        //
        //            }, withCancel: nil)
        //        }, withCancel: nil)
    }
    
    
    var timer: Timer?
    
    @objc private func reloadCollcetionViewData() {
        self.messageArray = Array(self.messageDictionary.values)
        self.sortMessages()
        DispatchQueue.global(qos: .userInteractive).async(execute: {
            DispatchQueue.main.async(execute: {
                print("we reloaded the data")
                self.collectionView?.reloadData()
            })
        })
    }
    
    private func attemptReloadCollecion() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadCollcetionViewData), userInfo: nil, repeats: false)
    }
    
    private func sortMessages() {
        self.messageArray.sort { $0.timestamp! > $1.timestamp!}
    }
    
    private  func fetchMessages() {
        self.dbReference.child("messages").observe(.childAdded, with: { (snapshot) in
            guard let dictionaryValue = snapshot.value as? [String: Any] else {return}
            let message = CurrentMessages(dictionaryValues: dictionaryValue)
            //            self.messageArray.append(message)
            //
            
            //            if let toId = message.toId {
            //                self.messageDictionary[toId] = message
            //                self.attemptReloadCollecion()
            //            }
            
            guard let chatPartnerId = message.chatPartnerId() else {return}
            self.messageDictionary[chatPartnerId] = message
            self.attemptReloadCollecion()
            
            
            
            
        }, withCancel: nil)
        
        
        
        //        let messageReference = Database.database().reference().child("messages").child(messageId)
        //        messageReference.observeSingleEvent(of: .value, with: { (snapshot) in
        //            guard let dictionaryValue = snapshot.value as? [String: Any] else {return}
        //            let message = CurrentMessages(dictionaryValues: dictionaryValue)
        //            guard let chatPartnerId = message.chatPartnerId() else {return}
        //            self.messageDictionary[chatPartnerId] = message
        //            self.attemptReloadCollecion()
        //        }, withCancel: nil)
    }
    
    
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupNavigationBar()
        
        messageArray.removeAll()
        messageDictionary.removeAll()
        collectionView?.allowsSelection = true
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
                self.obserUserMessages()
            })
        }
        setupCollectionViewConstraintLayout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView?.deselectAllItems(animated: true)
    }
    
    
    
    //MARK:- SetupCollectionview
    private func setupCollectionViewConstraintLayout() {
        collectionView?.backgroundColor = .backGroundLightBlue
        collectionView?.register(InboxCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //MARK:- Navigation
    func pushViewController(){
        let chatViewController = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        chatViewController.user = user
        navigationController?.pushViewController(chatViewController, animated: true)
        
        hideNavigationTabBar(true)
    }
    
    private func setupNavigationBar(){
        navigationItem.title = "Inbox"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .mainBlue
    }
    
    //MARK:- Helper Methods
    func delay(time: TimeInterval, closure: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: closure)
    }
    
}

extension AllMessagesController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let message = messageArray[indexPath.row]
        
        guard let chatPatnerId = message.chatPartnerId() else {return}
        let reference = Database.database().reference().child("users").child(chatPatnerId)
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else {return}
            
            let user = CurrentUser(dictionaryValues: dictionary)
            user.id = chatPatnerId
            self.delegate?.push(viewcontroller: self, withUser: user)
            
        }, withCancel: nil)
        
    }
    
}

extension AllMessagesController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InboxCell
        cell.message = messageArray[indexPath.row]
        return cell
        
    }
    
}

extension AllMessagesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 101)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}

extension AllMessagesController: InboxViewDelegate {
    func pushViewController(user: User, indexPath: IndexPath) {
        
    }
    
    func pushViewController(user: CurrentUser, indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let chatLogVC = ChatLogViewController(collectionViewLayout: layout)
        
        self.navigationController?.pushViewController(chatLogVC, animated: true)
        
        hideNavigationTabBar(true)
    }
}


extension AllMessagesController: InboxMessageDelegate {
    func push() {
        //        let layout = UICollectionViewFlowLayout()
        //        let chatViewController = ChatLogViewController(collectionViewLayout: layout)
        //        guard let index = collectionView?.indexPath(for: InboxCell()) else {return}
        
        //        let user = messageArray[index.row]
        
        //        push(viewcontroller: chatViewController, withUser: user)
    }
    
    func push(viewcontroller: UIViewController, withUser: CurrentUser) {
        let layout = UICollectionViewFlowLayout()
        let chatViewController = ChatLogViewController(collectionViewLayout: layout)
        chatViewController.user = withUser
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    
}












