//
//  DataModelService.swift
//  iBadoo
//
//  Created by Sergiu on 8/9/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import Firebase

class DataModelService {
    static var sharedInstance = DataModelService()
    
   private var _allUsersArray = [CurrentUser]()
    
    var allUserArray: [CurrentUser] {
        get { return _allUsersArray }
        set (newValue){
            _allUsersArray = newValue
        }
    }
    
    
    private init () { }
    
    private (set) var data: CurrentUser? {
        didSet {
            NotificationCenter.default.post(name: .init(rawValue: dataModelDidUpdateNotification), object: nil)
        }
    }
    
    func fetchUserData( completion: @escaping ([String]) -> () ) {
        
        
        //        self.data = "Data from wherever"
    }
    
    func checkUrl(_ urlString: String?) -> String? {
        let url = urlString
        if urlString == nil {
            return "https://api.letsbuildthatapp.com/youtube/home_feed"
        }
        return url
    }
    
   func fetchDataFrom<T: Decodable>(urlString: String? = nil ,completion: @escaping(T) -> () ) {
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async(execute: {
//        let urlStr = "https://api.letsbuildthatapp.com/youtube/home_feed"
                guard let urlStr = self.checkUrl(urlString) else {return}
        guard let url = URL(string: urlStr) else {return}
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Failed to fetch data:", error)
                        return
                    }
                    guard let data = data else {return}
                    do {
                        let obj = try JSONDecoder().decode(T.self, from: data)
                        completion(obj)
//                        self.data = obj as? HomeFeed
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    }.resume()
            })
        }
        
    }
    
    
    /// Fetching single User from Firebase
    func fetchUserFromFirebase(completion: @escaping (CurrentUser?) -> ()) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async(execute: {
                if Auth.auth().currentUser != nil {
                    guard let id = Auth.auth().currentUser?.uid else {return}
                    Database.database().reference().child("users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let dictionaryData = snapshot.value as? [String : AnyObject] else {return}
                        let user = CurrentUser(id: id, dictionaryValues: dictionaryData)
                        completion(user)
//                                        self.data = user
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
    
    func fetchAllUsersFromFirebase(completion: @escaping (CurrentUser) -> ()) {
            Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                guard let dictionaryValue = snapshot.value as? [String: Any] else {return}
                let userId = snapshot.key
                if userId != Auth.auth().currentUser?.uid {
                    let user = CurrentUser(id: userId, dictionaryValues: dictionaryValue)
                    completion(user)
                }
            }, withCancel: nil)
    }
    
    
    
    func fetchAllMessages(completion: @escaping (CurrentMessages?) -> ()) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async(execute: {
                if Auth.auth().currentUser != nil {
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    Database.database().reference().child("user-messages").child(uid).observe(.childAdded, with: { (snapshot) in
                        print(snapshot)
                        
                        let userId = snapshot.key
                        Database.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
                            print(snapshot)
                            
                            let messageId = snapshot.key
                            
                            //                        self.fetchMessageWith(messageId: messageId)
                            
                        }, withCancel: nil)
                    }, withCancel: nil)
                }
            })
        }
    }
    
}







let dataModelDidUpdateNotification = "dataModelDidUpdateNotification"

class Users: NSObject {
    var first_name: String?
    var last_name: String?
    var full_name: String?
    var email: String?
}



