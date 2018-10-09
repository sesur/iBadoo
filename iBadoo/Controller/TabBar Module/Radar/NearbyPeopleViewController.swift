//
//  NearbyPeopleViewController.swift
//  iBadoo
//
//  Created by Sergiu on 8/18/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import SwipeCellKit

enum ButtonDisplayMode {
    case titleAndImage, titleOnly, imageOnly
}

enum ButtonStyle {
    case backgroundColor, circular
}


class NearbyPeopleViewController: UICollectionViewController {
    
    //MARK:- Variables
    var defaultOptions = SwipeTableOptions()
    var isSwipeRightEnabled = true
    var buttonStyle: ButtonStyle = .backgroundColor
    var buttonDisplayMode: ButtonDisplayMode = .titleAndImage
    
    var nearbayPeopleArray: [CurrentUser] = []
    //    var allUsers: [CurrentUser] = []  // test
    
    
   var completionHandler: (() -> ())?
    
    
    let cellId = "cellId"
    
//    var delegate: InboxViewDelegate?
    lazy var allMessageVC: AllMessagesController = {
        let vc = AllMessagesController(collectionViewLayout: UICollectionViewFlowLayout())
//        vc.delegate = self
        return vc
    }()

    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        resetData()
    }
    
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = .backGroundLightBlue
        collectionView?.register(NeabyPeopleCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //Helper methods
    func createSelectedBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = .backGroundLightBlue //UIColor.lightGray.withAlphaComponent(0.2)
        return view
    }
    
    func resetData() {
        collectionView?.reloadData()
    }
    
    
    //MARK:- Helper Methods
    func delay(time: TimeInterval, closure: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: closure)
    }
    
    
    
}

extension NearbyPeopleViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbayPeopleArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NeabyPeopleCell
        cell.nearbyPeopleObserver = nearbayPeopleArray[indexPath.row]
        cell.selectedBackgroundView = createSelectedBackgroundView()
        cell.delegate = self
        return cell
    }
}

extension NearbyPeopleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 101)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
}



//MARK:- SwipeTableViewCellDelegate
extension NearbyPeopleViewController: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let user = nearbayPeopleArray[indexPath.row]
        
        switch orientation {
        case .left:
            return []
        case .right:
            
            let write = writeTo(user: user)
            
           // addFriend Action
            let addfriend = SwipeAction(style: .default, title: "Add friend") { (addAction, indexPath) in
                let updateStatus = !user.addFriend
                user.addFriend = updateStatus
                let cell = collectionView.cellForItem(at: indexPath) as! NeabyPeopleCell
                cell.setUnselected(updateStatus, animated: true)
            }
            addfriend.accessibilityLabel = user.addFriend ? "Delete friend" :  "Add friend"
            addfriend.hidesWhenSelected = true
            
            let test: ActionDescriptor = user.addFriend ? .deleteFriend : .addFriend
            configure(action: addfriend, with: test)
            
            //block/unlock Action
            let  block = SwipeAction(style: .default, title: nil) { blockAction, indexPath in
                let blockUserStatus = !user.blockFriend
                user.blockFriend = blockUserStatus
                
                let cell = collectionView.cellForItem(at: indexPath) as! NeabyPeopleCell
                cell.setUnselected(blockUserStatus, animated: true)
            }
            block.hidesWhenSelected = true
            block.accessibilityLabel = user.blockFriend ? "Unlock" : "Block"
            
            let blockDescriptor: ActionDescriptor = user.blockFriend ? .block : .unBlock
            configure(action: block, with: blockDescriptor)
            
            
            return [block, addfriend, write]
        }
    }
  
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        //        options.expansionStyle = orientation == .left ? .selection : .selection // destructiv
        options.expansionStyle = SwipeExpansionStyle(target: .percentage(0.0),
                                                     elasticOverscroll: true,
                                                     completionAnimation: .fill(.automatic(.reset, timing: .with)))
        
        //        options.expansionDelegate = ScaleTransition.default as? SwipeExpanding
        options.transitionStyle = .border //defaultOptions.transitionStyle
        
        switch buttonStyle {
        case .backgroundColor:
            options.buttonSpacing = 7 // 11
            options.backgroundColor = .backGroundLightBlue
        case .circular:
            options.buttonSpacing = 7 //4
            options.backgroundColor =  #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
        }
        
        return options
    }
    
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
        
        switch buttonStyle {
        case .backgroundColor:
            action.backgroundColor = descriptor.color
            action.textColor = .mainBlue
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        case .circular:
            action.backgroundColor = .backGroundLightBlue//.clear
            action.textColor = descriptor.color
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        }
    }
    
    private func writeTo(user: CurrentUser) -> SwipeAction {
        // Write Action
        // let write = SwipeAction(style: .default, title: nil, handler: nil)
        let write = SwipeAction(style: .default, title: nil) { (write, indexPath) in
            let tabBar = self.navigationController?.tabBarController as? CustomTabBarController
            
            //                self.allMessageVC.messageGroupID = "wevjbwjcbw"
            
            let allMessagesVC = AllMessagesController(collectionViewLayout: UICollectionViewFlowLayout())
            let chat = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
            chat.user = user
            
            tabBar?.setSelectIndex(from: 2, to: 1)
            self.delay(time: 0.01, closure: {
                tabBar?.inboxNavigationController.setViewControllers([allMessagesVC, chat], animated: true)
            })
        }
        write.hidesWhenSelected = true
        configure(action: write, with: .write)
        
        return write
    }
}
