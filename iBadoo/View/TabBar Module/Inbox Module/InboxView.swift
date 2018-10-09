//
//  InboxView.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/2/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import CoreData

protocol InboxViewDelegate {
    func pushViewController()
    func pushViewController(user: User, indexPath: IndexPath)
    func pushViewController(user: CurrentUser, indexPath: IndexPath)
}

class InboxView: BaseUIView {
    
    private let cellId = "cellId"
    var delegate: InboxViewDelegate?
    var blockoOperation = [BlockOperation]()
    
    lazy var fetchedResultController: NSFetchedResultsController = { () -> NSFetchedResultsController<NSFetchRequestResult> in
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastMessageR.date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "lastMessageR != nil")
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    private lazy var collectionView: UICollectionView = {
        let colectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colectionView.backgroundColor = .backGroundColor
        colectionView.delegate = self
        colectionView.dataSource = self
        colectionView.allowsSelection = true
        return colectionView
    }()
    
    //MARK:- Life Cycle
    override func setupViews() {
//        setupData()
//        setupCollectionViewConstraintLayout()
//        do {
//            try fetchedResultController.performFetch()
//            collectionView.reloadData() // was added
//        } catch let err {
//            debugPrint("Couln't fetch due: \(err.localizedDescription)")
//        }
    }
    
    //MARK:- Layouts
    private func setupCollectionViewConstraintLayout() {
        collectionView.register(InboxCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        collectionView.fillSuperView()
    }
}

extension InboxView: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            blockoOperation.append(BlockOperation(block: {
                self.collectionView.insertItems(at: [newIndexPath!])
            }))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            blockoOperation.forEach { $0.start() }
        }) { (completed) in
//            let lastItem = self.fetchedResultController.sections![0].numberOfObjects - 1
//            let indexPath = IndexPath(item: lastItem, section: 0)
            //            self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            self.collectionView.reloadData()
        }
    }
}


extension InboxView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = fetchedResultController.object(at: indexPath) as! User
        delegate?.pushViewController(user: user, indexPath: indexPath)
    }
}

extension InboxView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InboxCell
//        let user = fetchedResultController.object(at: indexPath) as? User
//        if  let userMessage = user?.lastMessageR {
//            cell.message = userMessage
//            return cell
//        }
        return cell
        
    }
}

extension InboxView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 101)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}






















