//
//  InboxHelper.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/8/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import CoreData

extension InboxView {
    
    func clearData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let context = appDelegate?.persistentContainer.viewContext {
            do {
                let entityArray = ["Message", "User"]
                for entityName in entityArray {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                    for object in objects! {
                        context.delete(object)
                    }
                }
                try context.save()
            } catch let err {
                debugPrint("Could not save \(err.localizedDescription)")
            }
        }
    }
    
    func setupData() {
        clearData()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let context = appDelegate?.persistentContainer.viewContext {
            
            let sergiu = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            sergiu.name = "Sergiu Suru"
            sergiu.profileImageName = "bitmap"
            
            //vadim
            createVadimMessageWith(context: context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            donald.name = "Donald Trump"
            donald.profileImageName = "trump"
            
//            InboxView.createMessageWith(text: "Your are fired !!! ", user: donald, minutesAgo: 60 * 24, context: context)
//            
//            let hillary = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
//            hillary.name = "Hilary Clinton"
//            hillary.profileImageName = "clinton"
//            
//            InboxView.createMessageWith(text: "I will save you!!! ", user: hillary, minutesAgo: 8 * 60 * 24, context: context)
       
            do {
                try context.save()
            } catch let err {
                print(err)
            }
        }
    }
    
    private func createVadimMessageWith(context: NSManagedObjectContext) {
        let vadim = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        vadim.name = "Vadim Hariton"
        vadim.profileImageName = "hariton"
        
//        InboxView.createMessageWith(text: "Noroc!", user: vadim, minutesAgo: 5, context: context)
//        InboxView.createMessageWith(text: "Ma chinui cu o forma, nu stiu cum sa o realizez, e prea complicata. ?", user: vadim, minutesAgo: 5, context: context)
//        InboxView.createMessageWith(text: "Poti te rog sa ma ajuti? Am incercat sa elaborez citeceva si totusi nu se ptrimeste sa obtin ceea ce vreau", user: vadim, minutesAgo: 3, context: context)
//        InboxView.createMessageWith(text: "Am deadline, in caz ca nu reusesc nu voi avea premiu :(. Incerc si incerc, testez diferite lucruri ca sa aduc la bun sfirsit taskul asta. Poate piina diseara reusesc sa-l solutionez cumva. ", user: vadim, minutesAgo: 2, context: context)
//        
//        // response message
//        InboxView.createMessageWith(text: "O sa te ajut desigur, imi descrii te rog problema ta pe care o ai, sa vedem unde este blockpoint-ul tau. Sper sa te pot ajuta cu ceva", user: vadim, minutesAgo: 2, context: context, isSender: true)
//        
//        InboxView.createMessageWith(text: "Hoooooo, am reusit pina la urma sa gasim solutia! In sfirsit am realizat si taskul acesta. Multumesc frumos ca m-ai ajuta, iti sunt dator cu multa bere :) ", user: vadim, minutesAgo: 1, context: context)
    }
    
    static func createMessageWith(text: String, user: User, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false ) -> Message {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.userR = user
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
        message.isSender = NSNumber(value: isSender) as! Bool
        user.lastMessageR = message
        return message
    }
}





















