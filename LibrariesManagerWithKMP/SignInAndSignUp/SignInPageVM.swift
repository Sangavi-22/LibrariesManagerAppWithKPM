//
//  SignInPageVM.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import KMPLibrariesManager

class SignInPageVM {
    func verify(emailId: String) -> Result<User, EmailIdError>{
        let userAccount = getParticularAccount(emailId)
        let validationSuccess: Bool = InputValidator.validateEmail(input: emailId)
        
        if userAccount != nil{
            return .success(userAccount!)
        }
        else if emailId.isEmpty {
            return .failure(.empty)
        }
        else if !(validationSuccess){
            return .failure(.invalid)
        }
        else {
            return .failure(.emailIdNotFound)
        }
    }
    
    func getParticularAccount(_ emailId: String) -> User? {
        do {
            return try dataSource.getAllUsers().first(where: {$0.emailId == emailId})
        } catch {
            return nil
        }
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
    
}


