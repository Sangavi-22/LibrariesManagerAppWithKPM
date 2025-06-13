//
//  SearchPageEmptyDataHandler.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

class SearchPageEmptyDataHandler: UIView{
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        textLabel.textColor = .systemGray2
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        self.backgroundColor = .systemBackground
        
        addSubview(imageView)
        addSubview(textLabel)
        
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 55),
        
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: 400),
            textLabel.heightAnchor.constraint(equalToConstant: 44)
            ])

    }
    
    func setDataInSubviews(text: String, imageName: String){
        textLabel.text = text
        imageView.image = UIImage(systemName: imageName)
    }
}
      

