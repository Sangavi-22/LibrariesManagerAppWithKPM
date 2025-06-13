//
//  ProfileTabVM.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import KMPLibrariesManager
class ProfileTabVM {
    func getUserDetails() -> User? {
        do {
            return try dataSource.getUserById(userId: UserDefaultsManager.retreiveString(for: .userIdOfAccount) ?? "")
        } catch {
            return nil
        }
    }
    
    func compareWithExistingPassword(_ inputtedPassword: String) -> Result<Bool, PasswordVerificationError>{
        guard let account = getUserDetails() else {
            return .failure(.passwordMismatches)
        }
        return verify(inputtedPassword, with: account)
    }
    
    func verify(_ password: String,
                with userAccount: User) -> Result<Bool, PasswordVerificationError>{
        // Used to verify the password by comparing with the password of previously fetched account
        if (password == userAccount.password) {
            return .success(true)
        } else if password.isEmpty {
            return .failure(.empty)
        } else {
            return .failure(.passwordMismatches)
        }
    }
    
    func validateUsingRegex(_ password: String) -> Bool{
        InputValidator.validatePassword(input: password)
    }
    
    func updatePassword(with newPassword: String){
        do {
            if let account = getUserDetails() {
                let newAccount = User(userId: account.userId,
                                      name: account.name,
                                      emailId: account.emailId,
                                      password: newPassword)
                try dataSource.updateUser(user: newAccount)
            }
        } catch {
            print("Failed while updating profile")
        }
    }
    
    func deleteCurrentAccount() {
        do {
            if let account = getUserDetails() {
                try dataSource.deleteUserById(userId: account.userId)
                UserDefaultsManager.removeFromUserDefaults(key: .userIdOfAccount)
                UserDefaultsManager.removeFromUserDefaults(key: .loggedIn)
            }
        } catch {
            print("Failed deleting profile")
        }
    }
}

enum PasswordVerificationError: String, Error {
    case empty = "Field is empty"
    case passwordMismatches = "Incorrect password"
}



