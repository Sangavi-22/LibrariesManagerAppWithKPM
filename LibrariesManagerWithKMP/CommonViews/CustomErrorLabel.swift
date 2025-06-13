//
//  CustomErrorLabel.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

class CustomErrorLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLabel(){
        
        self.frame.size = CGSize(width: 50, height: 10)
        
        self.textColor = .red
        self.font = .systemFont(ofSize: 12, weight: .semibold)
         
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
