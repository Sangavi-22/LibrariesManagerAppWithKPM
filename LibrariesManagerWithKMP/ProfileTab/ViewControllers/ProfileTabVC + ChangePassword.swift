//
//  ProfileTabVC + ChangePassword.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

extension ProfileTabVC {
    
    @objc func changePassword(){
        let alertController = UIAlertController(title: "Change password", message: "Please enter your current password", preferredStyle: .alert)
        
        alertController.addTextField{ (passwordField) in
            passwordField.placeholder = "Enter your password"
            passwordField.isSecureTextEntry = true
            passwordField.setUpVisibilityToggler()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){(result: UIAlertAction) -> Void in
            print()
        }
        
        let verifyAction = UIAlertAction(title: "Verify", style: .default) {[weak self](result: UIAlertAction) -> Void in
            if let currentPassword = alertController.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                self?.changePasswordAfterVerification(of: currentPassword)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(verifyAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    func changePasswordAfterVerification(of inputtedPassword: String){
        let passwordVerificationStatus: Result<Bool, PasswordVerificationError> = viewModel.compareWithExistingPassword(inputtedPassword)
        switch passwordVerificationStatus {
        case .success:
            inputNewPassword()
        case .failure(_):
            let content = ToastViewContent(image: UIImage(systemName: "exclamationmark.lock.fill"), title: "Sorry Verification failed", subtitle: "Password does'nt match")
            self.showToast(with: content)
        }
    }
    
    func inputNewPassword(){
        let alertController = UIAlertController(title: "New password Request", message: "Please enter the new password", preferredStyle: .alert)
        
        alertController.addTextField{ (passwordField) in
            passwordField.placeholder = "Enter your password"
            passwordField.isSecureTextEntry = true
            passwordField.setUpVisibilityToggler()
        }
        
        alertController.addTextField{ (confirmPasswordField) in
            confirmPasswordField.placeholder = "Confirm the password"
            confirmPasswordField.isSecureTextEntry = true
            confirmPasswordField.setUpVisibilityToggler()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){(result: UIAlertAction) -> Void in
            print()
        }
        
        let doneAction = UIAlertAction(title: "Done", style: .default) {(result: UIAlertAction) -> Void in
            if let newPassword = alertController.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let reenteredPassword = alertController.textFields![1].text?.trimmingCharacters(in: .whitespacesAndNewlines){
                self.validate(newPassword, reenteredPassword)
            }
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validate(_ newPassword: String, _ reenteredPassword: String){
        var content = ToastViewContent(image: UIImage(systemName: "xmark.circle.fill"), title: "Invalid password", subtitle: "Password can't be updated")
        
        let validPassword = self.viewModel.validateUsingRegex(newPassword)
        
        if validPassword && newPassword == reenteredPassword{
            self.viewModel.updatePassword(with: newPassword)
            content = ToastViewContent(image: nil, title: "Password Updated", subtitle: "Your password has been updated")
        }
        
        else if validPassword && !(newPassword == reenteredPassword){
            content = ToastViewContent(image: nil, title: "Confirmed password mismatches", subtitle: nil)
        }
        
        self.showToast(with: content)
    }
}

