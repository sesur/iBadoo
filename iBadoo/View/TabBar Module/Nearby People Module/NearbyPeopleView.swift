////
////  NearbyPeopleView.swift
////  iBadoo
////
////  Created by Sergiu Suru on 1/30/18.
////  Copyright © 2018 Sergiu Suru. All rights reserved.
////
//
//import UIKit
//import SwipeCellKit
//
//enum ButtonDisplayModeA {
//    case titleAndImage, titleOnly, imageOnly
//}
//
//enum ButtonStyleA {
//    case backgroundColor, circular
//}
//
//
//class NearByPeopleView: BaseUIView {
//
//    var downloadedUsers = [CurrentUser]()
//    
//    var usersObserver: CurrentUser? {
//        didSet {
//            guard let users = usersObserver else {return}
////            print(users.fullName)
////            downloadedUsers.append(users)
//        }
//    }
//
//    var defaultOptions = SwipeTableOptions()
//    var isSwipeRightEnabled = true
//    var buttonStyle: ButtonStyle = .backgroundColor
//    var buttonDisplayMode: ButtonDisplayMode = .titleAndImage
//    
//    private let cellId = "cellId"
//    
//    private lazy var collectionView: UICollectionView = {
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.backgroundColor = .backGroundColor
//        cv.delegate = self
//        cv.dataSource = self
//        cv.allowsSelection = true
//        return cv
//    }()
//    
//    override func setupViews() {
//        
//        super.setupViews()
//        setupCollectionViewConstraintLayout()
//        resetData()
//        
//        DispatchQueue.global(qos: .userInitiated).async {
//            DispatchQueue.main.async(execute: {
//                DataModelService.sharedInstance.fetchAllUsersFromFirebase { (users) in
//                    
//                
//                    print(users.fullName)
//                    
////                    DataModelService.sharedInstance.allUserArray.append(users)
//                    
//                    //                    self.downloadedUsers = [users]
////                print(self.downloadedUsers)
////                    self.downloadedUsers = DataModelService.sharedInstance.allUserArray
////                    print(DataModelService.sharedInstance.allUserArray)
//                }
//            })
//        }
//        
//        
//    }
//    private func setupCollectionViewConstraintLayout() {
//        collectionView.register(NeabyPeopleCell.self, forCellWithReuseIdentifier: cellId)
//        addSubview(collectionView)
//        collectionView.fillSuperView()
//    }
//    
//    
//    
//    // MARK: - Actions
//    
//    func moreTapped(_ sender: Any) {
//        let controller = UIAlertController(title: "Swipe Transition Style", message: nil, preferredStyle: .actionSheet)
//        controller.addAction(UIAlertAction(title: "Border", style: .default, handler: { _ in self.defaultOptions.transitionStyle = .border }))
//        controller.addAction(UIAlertAction(title: "Drag", style: .default, handler: { _ in self.defaultOptions.transitionStyle = .drag }))
//        controller.addAction(UIAlertAction(title: "Reveal", style: .default, handler: { _ in self.defaultOptions.transitionStyle = .reveal }))
//        controller.addAction(UIAlertAction(title: "\(isSwipeRightEnabled ? "Disable" : "Enable") Swipe Right", style: .default, handler: { _ in self.isSwipeRightEnabled = !self.isSwipeRightEnabled }))
//        controller.addAction(UIAlertAction(title: "Button Display Mode", style: .default, handler: { _ in self.buttonDisplayModeTapped() }))
//        controller.addAction(UIAlertAction(title: "Button Style", style: .default, handler: { _ in self.buttonStyleTapped() }))
//        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        controller.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { _ in self.resetData() }))
//        //        present(controller, animated: true, completion: nil)
//    }
//    
//    func buttonDisplayModeTapped() {
//        let controller = UIAlertController(title: "Button Display Mode", message: nil, preferredStyle: .actionSheet)
//        controller.addAction(UIAlertAction(title: "Image + Title", style: .default, handler: { _ in self.buttonDisplayMode = .titleAndImage }))
//        controller.addAction(UIAlertAction(title: "Image Only", style: .default, handler: { _ in self.buttonDisplayMode = .imageOnly }))
//        controller.addAction(UIAlertAction(title: "Title Only", style: .default, handler: { _ in self.buttonDisplayMode = .titleOnly }))
//        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        //        present(controller, animated: true, completion: nil)
//    }
//    
//    func buttonStyleTapped() {
//        let controller = UIAlertController(title: "Button Style", message: nil, preferredStyle: .actionSheet)
//        controller.addAction(UIAlertAction(title: "Background Color", style: .default, handler: { _ in
//            self.buttonStyle = .backgroundColor
//            self.defaultOptions.transitionStyle = .border
//        }))
//        controller.addAction(UIAlertAction(title: "Circular", style: .default, handler: { _ in
//            self.buttonStyle = .circular
//            self.defaultOptions.transitionStyle = .reveal
//        }))
//        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        //        present(controller, animated: true, completion: nil)
//    }
//    
//    //Helper methods
//    func createSelectedBackgroundView() -> UIView {
//        let view = UIView()
//        view.backgroundColor = .backGroundLightBlue //UIColor.lightGray.withAlphaComponent(0.2)
//        return view
//    }
//    
//    func resetData() {
////        usersArray = mockEmails
////        usersArray.forEach { $0.addFriend = false }
//        
////        downloadedUsers = allUsersArray
////        downloadedUsers.forEach { $0.addFriend = false }
//        collectionView.reloadData()
//    }
//}
//
//extension NearByPeopleView: UICollectionViewDelegate {
//    
//}
//
//extension NearByPeopleView: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return downloadedUsers.count //usersArray.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NeabyPeopleCell//NearByPeopleCell
//        cell.delegate = self
//        cell.selectedBackgroundView = createSelectedBackgroundView()
//        
////        let user = downloadedUsers[indexPath.row]
////        print(user)
//        
////        let user = usersArray[indexPath.row]
////        cell.fromLabel.text = user.from
////        cell.dateLabel.text = user.relativeDateString
////        cell.subjectLabel.text = user.subject
////        cell.bodyLabel.text = user.body
//        //cell.deleteFriend = user.deleteFriend
//        
//        //        cell.backgroundColor = .bgLightBlue
//        return cell
//    }
//}
//
//extension NearByPeopleView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 101)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.5
//    }
//    
//}
//
//
//
//extension NearByPeopleView: SwipeTableViewCellDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        
//        var user = downloadedUsers[indexPath.row] //usersArray[indexPath.row]
//        
//        //        if orientation == .left {
//        //            guard isSwipeRightEnabled else { return nil }
//        //
//        //            let read = SwipeAction(style: .default, title: nil) { action, indexPath in
//        //                let updatedStatus = !user.unread
//        //                user.unread = updatedStatus
//        //
//        //                let cell = collectionView.cellForItem(at: indexPath) as! MailCell
//        //                cell.setUnread(updatedStatus, animated: true)
//        //            }
//        //
//        //            read.hidesWhenSelected = true
//        //            read.accessibilityLabel = user.unread ? "Mark as Read" : "Mark as Unread"
//        //
//        //            let descriptor: ActionDescriptor = user.unread ? .read : .unread
//        //            configure(action: read, with: descriptor)
//        //
//        //            return [read]
//        //        } else {
//        
//        
//        let write: SwipeAction!
//        let addFriend: SwipeAction!
//        let block: SwipeAction!
//        
//        
//        if orientation == .right {
//            // write
//            write = SwipeAction(style: .default, title: nil, handler: nil)
//            write.hidesWhenSelected = true
//            configure(action: write, with: .write)
//            
//            //add/delete
//            addFriend = SwipeAction(style: .default, title: "Delete friend") { action, indexPath in
//                let addFriendStatus = !user.addFriend
//                user.addFriend = addFriendStatus
//                
//                let cell = collectionView.cellForItem(at: indexPath) as! NeabyPeopleCell
//                cell.setUnselected(addFriendStatus, animated: true)
//            }
//            addFriend.hidesWhenSelected = true
//            addFriend.accessibilityLabel = user.addFriend ? "Delete friend" :  "Add friend"
//            
//            let friendDescriptor: ActionDescriptor = user.addFriend ? .deleteFriend : .addFriend
//            configure(action: addFriend, with: friendDescriptor)
//            
//            //block/unlock
//            block = SwipeAction(style: .default, title: nil) { action, indexPath in
//                let blockUserStatus = !user.blockFriend
//                user.blockFriend = blockUserStatus
//                
//                let cell = collectionView.cellForItem(at: indexPath) as! NeabyPeopleCell
//                cell.setUnselected(blockUserStatus, animated: true)
//            }
//            block.hidesWhenSelected = true
//            block.accessibilityLabel = user.blockFriend ? "Unlock" : "Block"
//            
//            let blockDescriptor: ActionDescriptor = user.blockFriend ? .block : .unBlock
//            configure(action: block, with: blockDescriptor)
//            
//            return [block, addFriend, write]
//        }
//        
//        return []
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//        var options = SwipeTableOptions()
//        options.expansionStyle = orientation == .left ? .selection : .selection // destructive
//        options.transitionStyle = defaultOptions.transitionStyle
//        
//        switch buttonStyle {
//        case .backgroundColor:
//            options.buttonSpacing = 7 // 11
//            options.backgroundColor = .backGroundLightBlue
//        case .circular:
//            options.buttonSpacing = 7 //4
//            options.backgroundColor =  #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
//        }
//        
//        return options
//    }
//    
//    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
//        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
//        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
//        
//        switch buttonStyle {
//        case .backgroundColor:
//            action.backgroundColor = descriptor.color
//            action.textColor = .mainBlue
//            action.font = .systemFont(ofSize: 13)
//            action.transitionDelegate = ScaleTransition.default
//        case .circular:
//            action.backgroundColor = .backGroundLightBlue//.clear
//            action.textColor = descriptor.color
//            action.font = .systemFont(ofSize: 13)
//            action.transitionDelegate = ScaleTransition.default
//        }
//    }
//}
//
