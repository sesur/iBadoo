//
//  ChatLogController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/7/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData

class ChatLogViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    private let cellId = "cellId"
    private var bottomConstraint: NSLayoutConstraint?
    
    private let messageContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        return container
    }()
    var user: User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    //MARK:- Lazy vars
    private lazy var sendMessageTextView: UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: 17)
        text.textColor = .lightGray
        //        text.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 14)
        text.textContainerInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: -5)
        text.textContainer.lineFragmentPadding = 14
        text.text = PLACEHOLDER_TEXT
        text.layer.borderColor = #colorLiteral(red: 0.7453632951, green: 0.7963940501, blue: 0.8933854699, alpha: 1)
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 20
        text.layer.masksToBounds = true
        text.autocorrectionType = .no
        text.delegate = self
        text.selectedTextRange = text.textRange(from: text.beginningOfDocument, to: text.beginningOfDocument)
        return text
    }()
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "send")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .mainBlue
        button.addTarget(self, action: #selector(handleSendButtonTap), for: .touchUpInside)
        return button
    }()
    
    
    //MARK:- NSFetchedResultsController
    lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<NSFetchRequestResult> in
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
        fetchedRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchedRequest.predicate = NSPredicate(format: "userR.name = %@", self.user!.name!)
        let context = appDelegate.persistentContainer.viewContext
        let frc = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
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
            let lastItem = self.fetchedResultsController.sections![0].numberOfObjects - 1
            let indexPath = IndexPath(item: lastItem, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        })
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try fetchedResultsController.performFetch()
           // print(fetchedResultsController.sections![0].numberOfObjects)
        } catch let err {
            debugPrint("Couldn't fetche due \(err.localizedDescription)")
        }
        
        setupMessageContainerLayouts()
        setupKeyboardNotifications()
        collectionView?.backgroundColor = #colorLiteral(red: 0.9479215741, green: 0.9609569907, blue: 0.9931899905, alpha: 1)
        collectionView?.register(ChatLogCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        IQKeyboardManager.sharedManager().enable = false
         setupNavigation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.animationTabBarHidden(false)
        }
        
    }
    private func setupNavigation() {
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
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
    
    private func setupMessageContainerLayouts() {
        view.addSubview(messageContainerView)
        messageContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size:.init(width: 0, height: 65))
        
        bottomConstraint = NSLayoutConstraint(item: messageContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        setupContainerComponentsLayout()
    }
    private func setupContainerComponentsLayout() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = #colorLiteral(red: 0.7453632951, green: 0.7963940501, blue: 0.8933854699, alpha: 1)
        
        [sendMessageTextView, sendButton, topBorderView].forEach { messageContainerView.addSubview($0) }
        sendMessageTextView.anchor(top: messageContainerView.topAnchor, leading: messageContainerView.leadingAnchor, bottom: messageContainerView.bottomAnchor, trailing: messageContainerView.trailingAnchor, padding: .init(top: 10, left: 25, bottom: 10, right: 48), size: .zero)
        
        sendButton.anchor(top: sendMessageTextView.topAnchor, leading: nil, bottom: nil, trailing: messageContainerView.trailingAnchor, padding: .init(top: 7, left: 0, bottom: 0, right: 8), size: .init(width: 35, height: 35))
        
        topBorderView.anchor(top: messageContainerView.topAnchor, leading: messageContainerView.leadingAnchor, bottom: nil, trailing: messageContainerView.trailingAnchor, padding: .init(top: 1, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
    }
    
    //MARK:- Keyboard Notifications
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardTap), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardTap), name: .UIKeyboardWillHide, object: nil)
    }
    
    //MARK:- Actions
    @objc private func handleSendButtonTap() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let sendMessage = sendMessageTextView.text  else {return}
        
        if !sendMessage.isEmpty && sendMessage != PLACEHOLDER_TEXT {
            let filtteredText = sendMessage.trimmingCharacters(in: .whitespacesAndNewlines)
            InboxView.createMessageWith(text: filtteredText, user: user!, minutesAgo: 0, context: context, isSender: true)
            sendMessageTextView.text = nil
            if sendMessageTextView.text.isEmpty {
                applyPlaceholderStyle(textView: sendMessageTextView)
            }
        }
        do {
            try context.save()
        } catch let err {
            debugPrint("Couldn't save due error \(err.localizedDescription)")
        }
    }
    
    deinit {
                NotificationCenter.default.removeObserver(self)
            }
    
    @objc private func handleKeyboardTap(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboardFrameSize = ((userInfo[UIKeyboardFrameBeginUserInfoKey]) as AnyObject).cgRectValue else {return}
            let isKeyboardShowing = notification.name == .UIKeyboardWillShow
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrameSize.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                if isKeyboardShowing {
                    let lastItem = self.fetchedResultsController.sections![0].numberOfObjects - 1
                    let indexPath = IndexPath(item: lastItem, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            })
        }
    }
    
    
    @objc private func handleSimulateButtonTap(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        InboxView.createMessageWith(text: "A text message was sent few minutes ago ... ", user: user!, minutesAgo: 1, context: context)
        InboxView.createMessageWith(text: "Another message received a while ago ...  ", user: user!, minutesAgo: 1, context: context)
        do {
            try context.save()
        } catch let err {
            debugPrint("Couldn't fetch due: \(err.localizedDescription)")
        }
    }
    
    
    //MARK:- Navigation
    @objc private func handleMoreButtonTap() {
//        navigationController?.present(FriendProfileVC(), animated: true, completion: nil)
//        let nc = UINavigationController(rootViewController: friendProfileVC)
        
        let friendProfileVC = UserProfileViewController()
        navigationController?.pushViewController(friendProfileVC, animated: true)
        
//        navigationController?.present(nc, animated: true, completion: nil)
//        present(FriendProfileVC(), animated: true, completion: nil)
    }
}


extension ChatLogViewController {
    
    //MARK:- Datasource & Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultsController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogCell
        let message = fetchedResultsController.object(at: indexPath) as! Message
        
        if let messageText = message.text, let profileImageName = message.userR?.profileImageName  {
            cell.chatMesage = messageText
            cell.profileImageView.image = UIImage(named: profileImageName)
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesLineFragmentOrigin
            let estimateFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)], context: nil)
            
            if !message.isSender {
                cell.messageTextView.frame = CGRect(x: 65 + 8 + 16 + 8, y: 0, width: estimateFrame.width + 16 + 4, height: estimateFrame.height + 20)
                cell.bubbleView.frame = CGRect(x: 65 + 8, y: 0, width: estimateFrame.width + 16 + 28 + 8, height: estimateFrame.height + 20)
                cell.profileImageView.isHidden = false
                cell.bubbleImageView.image = ChatLogCell.grayBubbleImage
                cell.bubbleImageView.tintColor = #colorLiteral(red: 0.8961514831, green: 0.9179288745, blue: 0.9744198918, alpha: 1)
                cell.messageTextView.textColor = .black
                
            } else  {
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimateFrame.width - 16 - 16, y: 0, width: estimateFrame.width + 16 , height: estimateFrame.height + 20)
                cell.bubbleView.frame = CGRect(x: view.frame.width - estimateFrame.width - 16 - 20 - 4, y: 0, width: estimateFrame.width + 16 + 16, height: estimateFrame.height + 20)
                cell.profileImageView.isHidden = true
                cell.bubbleImageView.image = ChatLogCell.blueBubbleImage
                cell.bubbleImageView.tintColor = .mainBlue
                cell.messageTextView.textColor = .white
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendMessageTextView.endEditing(true)
    }
}
