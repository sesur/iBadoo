//
//  ChatLogViewController+Extention.swift
//  iBadoo
//
//  Created by Sergiu Suru on 2/15/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit
import FirebaseStorage

extension ChatLogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        
        if let text = messagesArray[indexPath.row].message {
            height = estimateFrame(forText: text).height + 20
        }
        
        
//        let message = fetchedResultsController.object(at: indexPath) as! Message
//        if let messageText = message.text {
//            let size = CGSize(width: 250, height: 1000)
//            let options = NSStringDrawingOptions.usesLineFragmentOrigin
//            let estimateFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)], context: nil)
//
//            return CGSize(width: view.frame.width, height: estimateFrame.height + 20)
//        }
        
        let width = UIScreen.main.bounds.width // fix the landscape issue
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout() // works only on landcape mode
    }
    
    
    func estimateFrame(forText: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        return NSString(string: forText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], context: nil)
    }
}



extension ChatLogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        navigationController?.dismiss(animated: true, completion: nil)
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
