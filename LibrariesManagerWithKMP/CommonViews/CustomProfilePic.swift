//
//  CustomProfilePic.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
class CustomProfilePic: UIImageView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize(){
        self.layer.cornerRadius = self.frame.size.width / 2 - 40
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        self.image = UIImage(systemName: "person.circle")
        self.tintColor = .label
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
