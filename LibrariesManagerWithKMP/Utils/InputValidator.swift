//
//  InputValidator.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import Foundation

struct InputValidator{
    
    static func validateEmail(input: String) -> Bool{
        input.range(of: "([A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3})", options: .regularExpression) != nil
    }
    
    static func validateMobileNum(input: String) -> Bool{
        input.range(of: "^\\d{10}$", options: .regularExpression) != nil
    }
    
    static func validatePassword(input: String) -> Bool{
        let passwordPattern =
            // At least 8 characters
            #"(?=.{8,})"# +

            // At least one capital letter
            #"(?=.*[A-Z])"# +
                
            // At least one lowercase letter
            #"(?=.*[a-z])"# +
                
            // At least one digit
            #"(?=.*\d)"# +
                
            // At least one special character
            #"(?=.*[ !@$%&?._-])"#
        
        return input.range(of: passwordPattern, options: .regularExpression) != nil
    }
    
    static func validateCost(input: String) -> Bool{
        input >= "0" && input.range(of:  "^\\d+(\\.\\d{1,2})?$", options: .regularExpression) != nil
    }
    
    static func validateStock(input: String) -> Bool{
        guard let input = Int(input)  else { return false }
        return input >= 0 && input <= 200
    }
    
    static func validateNum(input: String) -> Bool{
        input.range(of:  "\\d+", options: .regularExpression) != nil
    }
    
}

 
