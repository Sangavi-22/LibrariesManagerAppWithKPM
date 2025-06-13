//
//  CustomButton.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 12/06/25.
//

import UIKit

class CustomButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpButton(){
        self.configuration = .filled()
        
        self.configuration?.baseBackgroundColor = .systemOrange
        self.configuration?.baseForegroundColor = .black
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


