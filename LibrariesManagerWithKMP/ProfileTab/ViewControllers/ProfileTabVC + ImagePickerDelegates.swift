//
//  ProfileTabVC + ImagePickerDelegates.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import QuickLook
extension ProfileTabVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func changeProfilePicture() {
        let alertController = UIAlertController(title: "Profile picture editing options", message: "", preferredStyle: .actionSheet)
        
        var actions: [UIAlertAction] = []
        
        if let defaultImage = UIImage(systemName: "person.circle"),
           profilePicture.image?.pngData() == defaultImage.pngData() || editProfile {
            actions = choosePhotosFromSourcesOptions()
        } else {
            actions = editPhotosOptions()
        }
        
        for action in actions{
            alertController.addAction(action)
        }
        
        editProfile = false
        
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = self.view.bounds
            popoverPresentationController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
        
    func editPhotosOptions() -> [UIAlertAction]{
        let viewProfileAction = UIAlertAction(title: "View", style: .default, handler: { [weak self](_: UIAlertAction) in
            let previewController = QLPreviewController()
            previewController.delegate = self
            previewController.dataSource = self
            previewController.currentPreviewItemIndex = 0
            self?.present(previewController,animated: true, completion: nil)
        })
        
        let editProfile = UIAlertAction(title: "Change profile", style: .default, handler: { [weak self](_: UIAlertAction) in
            self?.editProfile = true
            self?.changeProfilePicture()
        })
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive, handler: { [weak self](_: UIAlertAction) in
            self?.profilePicture.image = UIImage(systemName: "person.circle")
        })

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        return [viewProfileAction, editProfile, removeAction, cancelAction]
    }
    
    func choosePhotosFromSourcesOptions() -> [UIAlertAction]{
        let camera = UIAlertAction(title: "Take Photo", style: .default, handler: { [unowned self](_: UIAlertAction) in
            let pickerController = self.imagePickerController
            self.photoManager.checkCamPermissionAndTakePhoto(using: pickerController)
        })
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: { [unowned self](_: UIAlertAction) in
            let pickerController = self.imagePickerController
            self.photoManager.present(pickerController, with: .photoLibrary)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        return [camera, photoLibrary, cancelAction]
    }
        
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.profilePicture.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}


