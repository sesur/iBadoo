//
//  PickerTestVC.swift
//  iBadoo
//
//  Created by Sergiu on 9/8/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import FirebaseStorage

class PickerTestVC: UIViewController {
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        navigationController?.present(imagePicker, animated: true, completion: nil)
        
//        navigationController?.pushViewController(imagePicker, animated: true)
        
        let messageLabel = UILabel(frame: CGRect(x: 90, y: 200, width: 250, height: 70))
        messageLabel.text = "Select an image from here ..."
//        messageLabel.addTarget(self, action: #selector(handleCancelTap), for: .touchUpInside)
        
        
        let messageLabel1 = UILabel(frame: CGRect(x: 90, y: messageLabel.frame.size.height + 20 , width: 300, height: 70))
        messageLabel1.text = "We are still working on this page!"
        messageLabel.textColor = .red
        messageLabel1.adjustsFontSizeToFitWidth = true
        messageLabel1.sizeToFit()
        
        let cancel = UIButton(frame: CGRect(x: 90, y: messageLabel1.frame.size.height + 20, width: 250, height: 70))
        cancel.setTitle("Cancel", for: .normal)
        cancel.backgroundColor = .red
        cancel.addTarget(self, action: #selector(handleCancelTap), for: .touchUpInside)
        
        
        view.addSubview(messageLabel)
        view.addSubview(messageLabel1)
        view.addSubview(cancel)
        view.backgroundColor = .white
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideNavigationTabBar(true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        hideNavigationTabBar(false)
    }
    

    @objc private func handleCancelTap() {
//        navigationController?.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
}

extension PickerTestVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            uploadToFirebaseStorageUsingImage(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
        //        navigationController?.dismiss(animated: true, completion: nil)
        //        dismiss(animated: true) {
        //            self.navigationController?.popToRootViewController(animated: true)
        //        }
        
        
        //        dismiss(animated: true) {
        //            let tabBar = self.navigationController?.tabBarController as? CustomTabBarController
        //
        //            let allMessagesVC = AllMessagesController(collectionViewLayout: UICollectionViewFlowLayout())
        //            let chat = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        //
        //            tabBar?.setSelectIndex(from: 2, to: 1)
        //            self.delay(time: 0.01, closure: {
        //                tabBar?.inboxNavigationController.setViewControllers([allMessagesVC, chat], animated: true)
        //            })
        //        }
    }
    
    private func uploadToFirebaseStorageUsingImage(_ image: UIImage) {
        let imageName = UUID().uuidString
        
        let reference = Storage.storage().reference().child("message_images").child(imageName)
        
        guard let uploadingData = image.jpegData(compressionQuality: 0.2) else {return}
        reference.putData(uploadingData, metadata: nil) { (metadata, error) in
            if error != nil {
                print("Failed to upload image: ", error?.localizedDescription as Any)
                return
            }
            reference.downloadURL(completion: { (url, error) in
                print(url?.absoluteString ?? "")
            })
            //            print(metadata?.downloadURL()?.absoluteString)
        }
        
        print("UPLOADED IMMAGe TO FIREBASE")
        
        
    }
    
    
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
