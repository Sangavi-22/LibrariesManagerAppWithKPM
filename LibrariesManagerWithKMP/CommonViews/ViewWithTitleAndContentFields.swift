//
//  ViewWithTitleAndContentFields.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

class ViewWithTitleAndContentFields: UIView{
    
    let iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.tintColor = .label
        iconImage.largeContentImageInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        iconImage.layer.cornerRadius = 5
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        return iconImage
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textAlignment = .right
        contentLabel.font = .systemFont(ofSize: 14.5)
        contentLabel.numberOfLines = 2
        contentLabel.adjustsFontSizeToFitWidth = true
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        return contentLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeView(){
        setUpView()
        addSubviewsToView()
        setConstraints()
    }
    
    func setUpView(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviewsToView(){
        self.addSubview(iconImage)
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
    }
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImage.topAnchor.constraint(equalTo: topAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 21),
            iconImage.heightAnchor.constraint(equalToConstant: 21),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 82),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentLabel.topAnchor.constraint(equalTo: topAnchor),
             ])
    }
    
    func configure(with imageName: String, and title: String, also content: String){
        iconImage.image = UIImage(systemName: imageName)
        titleLabel.text = title
        contentLabel.text = content
    }
    
}
