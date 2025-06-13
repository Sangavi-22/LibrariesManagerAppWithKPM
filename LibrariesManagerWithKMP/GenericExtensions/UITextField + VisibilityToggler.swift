//
//  UITextField + VisibilityToggler.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
extension UITextField{
    
    func setUpPasswordField(){
        self.customize()
        self.setUpVisibilityToggler()
    }
    
    func customize(){
        self.isSecureTextEntry = true
        self.keyboardType = .emailAddress
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.borderColor = UIColor.secondarySystemFill.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpVisibilityToggler(){
        self.rightView = createVisibilityToggler()
        self.rightViewMode = .always
    }
    
    func createVisibilityToggler() -> UIButton{
        let visibilityToggler = UIButton(frame: CGRect(x: self.frame.size.width - 25, y: 5, width: 25, height: 25))
        visibilityToggler.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        visibilityToggler.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
//        visibilityToggler.configuration?.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 4)
        visibilityToggler.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
        return visibilityToggler
    }
    
    @objc func toggleVisibility(_ sender: UIButton){
        if self.isSecureTextEntry{
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        else{
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        self.isSecureTextEntry.toggle()
    }
    
}
