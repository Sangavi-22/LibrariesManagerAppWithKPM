//
//  ProfileTabVC + DeleteAccount.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
extension ProfileTabVC {
    
    @objc func deleteAccount(){
        let alertController = UIAlertController(title: "Delete Account", message: "Please enter your current password", preferredStyle: .alert)
        
        alertController.addTextField{ (passwordField) in
            passwordField.placeholder = "Enter your password"
            passwordField.isSecureTextEntry = true
            passwordField.setUpVisibilityToggler()
        }

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self](result: UIAlertAction) -> Void in
            if let password = alertController.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                self?.deleteAccountAfterVerification(of: password)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default){(result: UIAlertAction) -> Void in
            print()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func deleteAccountAfterVerification(of inputtedPassword: String){
        let passwordVerificationStatus: Result<Bool, PasswordVerificationError> = viewModel.compareWithExistingPassword(inputtedPassword)
        
        switch passwordVerificationStatus {
        case .success:
            removeCurrentAccount()
            goOutOfAccount()
            
        case .failure(_):
            let content = ToastViewContent(image: UIImage(systemName: "exclamationmark.lock.fill"), title: "Sorry verification failed", subtitle: "Can't delete the account")
            self.showToast(with: content)
        }
        
    }
    
    func removeCurrentAccount(){
        viewModel.deleteCurrentAccount() 
    }
}

