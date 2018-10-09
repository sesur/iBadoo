//
//  LoginViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/11/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//


import UIKit
import FacebookCore
import FacebookLogin
import FirebaseAuth
import JGProgressHUD
import SwiftyJSON
import FirebaseStorage
import FirebaseDatabase
import ProgressHUD



class LoginViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    var hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.loginController  = self
        return view
    }()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        dismissKeyboard()
        
//        view.addSubview(facebookLoginButton)

        
//        facebookLoginButton.anchor(top: loginView.bottomAnchor, leading: view.leadingAnchor , bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 35, bottom: 0, right: 35), size: .init(width: 0, height: 44))

        // Location
        
        if haveAccessToUserLocation() {
            
            //            let altitude: NSNumber = NSNumber(value: appDelegate.coordinates)
            
            let latitude: NSNumber = NSNumber(value: appDelegate.coordinates!.latitude)
            let longitude: NSNumber = NSNumber(value: appDelegate.coordinates!.longitude)
            print("Lonh: \(longitude) - latidute:\(latitude)")
            
            //            sendMessage(text: nil, date: Date(), picture: nil, location: nil, video: nil, audio: nil)
        }
        
        
    }
    
    //    func sendMessage(text: String?, date: Date, picture: UIImage?, location: String?, video: NSURL?, audio: String?) {
    //        if location != nil {
    //            print("Send location")
    //            let latitude: NSNumber = NSNumber(value: appDelegate.coordinates!.latitude)
    //            let longitude: NSNumber = NSNumber(value: appDelegate.coordinates!.longitude)
    //        }
    //    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        UIApplication.shared.statusBarStyle = .default
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    private func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    
    //MARK:- Location access
    private func haveAccessToUserLocation() -> Bool {
        if appDelegate.locationManager != nil {
            return true
        } else {
            Service.showAlert(onViewController: self, style: .alert, title: "Location", message: "Please give access to location in Settings")
            
            return false
        }
        
    }
    
    
    //MARK:- Fetch Data
//    private func fetchData() {
//        DataModelService.sharedInstance.fetchDataFrom { (homeFeed: HomeFeed) in
//            NotificationCenter.default.addObserver(self, selector: #selector(self.getUserData), name: NSNotification.Name(rawValue: dataModelDidUpdateNotification), object: nil)
//        }
//    }
//    @objc private func getUserData() {
//        //        if let data = DataModelService.sharedInstance.data {
//        //            //            data.videos.forEach({
//        //            //                print($0.channel.name, $0.name)
//        //            //            })
//        //        }
//    }
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: dataModelDidUpdateNotification), object: self)
//    }
//    
    
    //MARK:- Login
    @objc func handleFacebookLoginTap() {
        hud.textLabel.text = "Logging with Facebook..."
        hud.show(in: view, animated: true)
        
        FacebookAuthenticationService.signIn(onFacebookSuccese: { (token) in
            self.hud.dismiss(afterDelay: 0, animated: true)
            ProgressHUD.showSuccess("Successfully logged in Facebook")
            FirebaseAuthService.signIn(token.authenticationToken, onFirebaseSuccese: { (userName) in
//                self.handleLoginTap()
                ProgressHUD.showSuccess("Successfully logged in the app")
                self.pushToTabBarController()
//
            }, onError: { (error) in
                print(error ?? " ")
            })
            
        }) { (error) in
            print(error ?? " ")
            self.hud.dismiss(afterDelay: 0.4, animated: true)
        }
    }
    
    private func checkIfUserIsLogin() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                self.perform(#selector(self.handleLoginTap), with: nil, afterDelay: 0)
                return
            }
        }
    }
    
    
    //MARK:- Actions
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Navigation
    @objc func handleBackButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleCloseButtonTap() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func handleForgotButtonTap() {
        navigationController?.pushViewController(ConfirmSmsViewController(), animated: true)
    }
    @objc func handleDoNotHaveButtonTap() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    
    //MARK:- Login
    @objc func handleLoginTap(){
        if loginView.phoneTextField.text != "" && loginView.passwordTextField.text != "" {
//            ProgressHUD.showSuccess("Successfully logged")
            self.loginUser()
        } else {
            ProgressHUD.showError("Email and Password are missing")
        }
    }
    
    func loginUser() {
        ProgressHUD.show("Logging...")
//        FUser.loginUserWith(email: <#T##String#>, password: <#T##String#>, completion: <#T##(Error?) -> Void#>)
    }
    
   @objc func pushToTabBarController() {
        navigationController?.initRootViewController(viewController: CustomTabBarController(), transitionType: "fromBottom", duration: 0.1)
    }
    
    
    
    
    
    
    
    
    //MARK:- Layouts
    private func setupLayouts() {
        [loginView].forEach {view.addSubview($0)}
        loginView.fillSuperView()
    }
}
