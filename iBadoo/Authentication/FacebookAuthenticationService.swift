//
//  FacebookAuthenticationService.swift
//  iBadoo
//
//  Created by Sergiu on 9/14/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin
import JGProgressHUD


class FacebookAuthenticationService {
    
    //MARK:- Signin Facebook
    class func signIn(onFacebookSuccese: @escaping (_ token: AccessToken) -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        LoginManager().logIn(readPermissions: [.email, .publicProfile], viewController: LoginViewController()) { (loginResult) in
            switch loginResult {
            case .success(grantedPermissions: _, declinedPermissions: _ , token: let token):
                fetchFacebookUser(token, completion: { (response, image) in
                    onFacebookSuccese(token)
                })
            case .failed(let error):
                onError(error.localizedDescription)
            //                Service.dismissHud(Service.hud, text: "Error", detailText: "Failed to get Facebook user with error: \(error.localizedDescription)", withDelay: 3)
            case .cancelled:
                Service.dismissHud(Service.hud, text: "Error", detailText: "Canceled getting Facebook user.", withDelay: 5)
            }
        }
    }
    
    
    //MARK:-  Fetch facebook User
    class func fetchFacebookUser(_ token: AccessToken? = nil , completion: @escaping (ProfileGraphRequest.Response?, UIImage?) -> ()) {
        let connection = GraphRequestConnection()
        connection.add(ProfileGraphRequest()) { (response, result) in
            switch result {
            case .failed(let error): print(error)
                
            case .success(response: let response):
                handleFacebookResponse(response: response, completion: { image in
                    completion( response, image)
                })
            }
        }
        connection.start()
    }
    
    class  func handleFacebookResponse(response: ProfileGraphRequest.Response, completion: @escaping (UIImage?)->()){
        fetchImageFrom(response: response) { (image) in
            completion(image)
            
        }
    }
    
    //MARK:- Helper Methods
    class private func fetchImageFrom(response: ProfileGraphRequest.Response, completion: @escaping (UIImage?) -> ()){
        guard let url = response._profilePictureUrl else {return}
        DispatchQueue.global(qos: .userInteractive).sync {
            DispatchQueue.main.async {
                fetch(url: url) { (image) in
                    completion(image)
                }
            }
        }
        
    }
    
    class func fetch(url: String?, completion: @escaping (UIImage?)-> () ) {
        guard let profilePictureUrl = url else {return}
        guard let url = URL(string: profilePictureUrl) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            completion(image)
        }).resume()
    }
}
