//
//  UserDefaultsManager.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import Foundation

struct UserDefaultsManager{
    
    static func saveToUserDefaults(key: UserDefaultsKey, value: String){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func saveToUserDefaults(key: UserDefaultsKey, value: Bool){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func retreiveBool(for key: UserDefaultsKey) -> Bool?{
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    static func retreiveString(for key: UserDefaultsKey) -> String?{
        UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func removeFromUserDefaults(key: UserDefaultsKey){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}

enum UserDefaultsKey: String{
    case userIdOfAccount
    case loggedIn
}
