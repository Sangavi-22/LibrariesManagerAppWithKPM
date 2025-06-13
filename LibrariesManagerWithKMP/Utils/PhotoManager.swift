//
//  PhotoManager.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import AVFoundation

class PhotoManager{
    
    weak var delegate: UIViewController?
    
    func checkCamPermissionAndTakePhoto(using imagePickerController: UIImagePickerController){
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authorizationStatus{
        case .authorized:
            self.present(imagePickerController, with: .camera)
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video){ granted in
                if granted{
                    DispatchQueue.main.async {
                        self.present(imagePickerController, with: .camera)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.askForCamPermission()
                    }
                }
            }
            
        default:
            self.askForCamPermission()
        }
    }
    
    func askForCamPermission(){
        let alertController = createAlertRequestingCamPermission()
        self.delegate?.present(alertController, animated: true, completion: nil)
    }
    
    func createAlertRequestingCamPermission() -> UIAlertController{
        let alert = UIAlertController(
            title: "Camera Access Denied",
            message: "Please enable camera access in Settings to take photos.",
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    func present(_ imagePickerController: UIImagePickerController,
                 with sourceType: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            imagePickerController.sourceType = sourceType
            self.delegate?.present(imagePickerController, animated: true, completion: nil)
        }
        
        else{
            self.showSourceTypeUnAvailable()
        }
    }
    
    func showSourceTypeUnAvailable(){
        let alert = createAlertForSourceUnAvailableMsg()
        self.delegate?.present(alert, animated: true, completion: nil)
    }
    
    func createAlertForSourceUnAvailableMsg() -> UIAlertController{
        let alert = UIAlertController(
            title: "Source Not Available",
            message: "The selected source type is not available.",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        return alert
    }
}
