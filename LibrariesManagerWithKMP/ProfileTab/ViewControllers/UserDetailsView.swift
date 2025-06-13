//
//  UserDetailsView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

class UserDetailsView: UIView{
    
    let emailIdView = ViewWithTitleAndContentFields()
    let nameView = ViewWithTitleAndContentFields()
    
    var commonConstraints: [NSLayoutConstraint]!
    var potraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameView, emailIdView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        checkDeviceOrientation()
        setLabelAlignment()
        checkUIStyle()
    }
    
    func setUpView(){
        addSubviewsToView()
        setConstraintsToSubviews()
        checkDeviceOrientation()
        setLabelAlignment()
        checkUIStyle()
    }
    
    func checkDeviceOrientation(){
        NSLayoutConstraint.activate(commonConstraints)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let currentOrientation = windowScene.interfaceOrientation
        
        if currentOrientation.isPortrait{
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(potraitConstraints)
        }
        else{
            NSLayoutConstraint.deactivate(potraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        }
    }
    
    func setLabelAlignment(){
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let currentOrientation = windowScene.interfaceOrientation
        
        if currentOrientation.isPortrait{
            emailIdView.contentLabel.textAlignment = .right
            nameView.contentLabel.textAlignment = .right
        }
        else{
            emailIdView.contentLabel.textAlignment = .left
            nameView.contentLabel.textAlignment = .left
        }
    }
    
    
    func checkUIStyle(){
        if traitCollection.userInterfaceStyle == .dark{
            self.backgroundColor = .secondarySystemBackground
        }
        else{
            self.backgroundColor = .systemBackground
        }
    }
    
    func addSubviewsToView(){
        self.addSubview(stackView)
    }
    
    func setConstraintsToSubviews(){
        commonConstraints = [
            nameView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            emailIdView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            emailIdView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
            ]
        
        potraitConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)]
        
        landscapeConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.widthAnchor.constraint(equalToConstant: 350),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 70),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
    }
    
    func configure(with account: User){
        emailIdView.configure(with: "mail", and: "Email", also: (account.emailId.isEmpty) ? "-" : account.emailId)
        
        nameView.configure(with: "person", and: "Name", also: (account.name.isEmpty) ? "-" : account.name)
    }

}
