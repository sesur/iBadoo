//
//  FirebaseAuthService.swift
//  iBadoo
//
//  Created by Sergiu on 9/14/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation
import Firebase
import JGProgressHUD

class FirebaseAuthService {
    
    //MARK:- Signin Firebase
    class func signIn(_ token: String?, onFirebaseSuccese: @escaping (String?) -> Void, onError: @escaping (String?) -> Void) {
        guard let token = token else {return}
        let facebookCredentials = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signInAndRetrieveData(with: facebookCredentials) { (userData, error) in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            fetchAndSaveFacebookUser(completion: {
                onFirebaseSuccese(userData?.user.displayName)
            })
        }
    }
    
    
    //MARK:- Fetch users data
    class func fetchAndSaveFacebookUser(completion: @escaping () -> ()) {
        FacebookAuthenticationService.fetchFacebookUser(completion: { (response, image) in
            guard let image = image else {return}
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            DispatchQueue.global(qos: .userInteractive).async(execute: {
                DispatchQueue.main.async {
                    fetchUserFirebase(image: image, completion: { (profileImageUrl) in
                        let values = self.userData(response, imageUrl: profileImageUrl)
                        registerUserIntoFirebaseWith(uid: uid, values: values, completion: {
                            completion()
                        })
                    })
                }
            })
        })
    }
    
    class func fetchUserFirebase(image: UIImage?, completion: @escaping (String?)->() ) {
        let uploadData = convetImageIntoData(image: image)
        storageReference(parentName: "profileImages", data: uploadData) { (profileImageUrl) in
            completion(profileImageUrl)
        }
    }
    
    
    //MARK:- Save User into Firebase
    class func registerUserIntoFirebaseWith(uid: String, values: [String: Any], completion: @escaping()-> ())  {
        databaseReference(parentName: "users", id: uid, values: values)
        print("Succesefully saved user into Firebase database")
        completion()
    }
    
    
    //MARK:- Firebase Reference
    class private func databaseReference(parentName: String, id: String, values: [String : Any]) -> () {
        return Database.database().reference().child(parentName).child(id).updateChildValues(values) { (error, reference) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    class private func storageReference(parentName: String, data: Data, completion: @escaping (String?)-> ()) {
        let fileName = UUID().uuidString
        let storageRef = Storage.storage().reference().child(parentName).child("\(fileName).jpg")
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let profileImageURL = url?.absoluteString else { return }
                completion(profileImageURL)
            }
        }
    }
    
    //MARK:- Helper Methods
    class private func userData(_ response: ProfileGraphRequest.Response?, imageUrl: String?) -> [String: Any] {
        var dictionaryValue =  [String : Any]()
        
        if let fullName = response?._fullName,
            let firstName = response?._firstName,
            let lastName = response?._lastName,
            let email = response?._email,
            let imageUrl = imageUrl
        {
            dictionaryValue = ["fullName": fullName,
                               "firstName": firstName,
                               "lastName": lastName,
                               "email": email,
                               "imageUrl": imageUrl]
        }
        return dictionaryValue
    }
    
    
    class private func convetImageIntoData(image: UIImage?) -> Data {
        var uploadData = Data()
        if let dataImage = image?.jpegData(compressionQuality: 0.5) {
            uploadData = dataImage
        }
        return uploadData
    }
    
    class func downloadImage(reference: StorageReference, completion: @escaping (String?)-> ()) {
        reference.downloadURL { (url, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            completion(url?.absoluteString)
        }
    }
    
}
