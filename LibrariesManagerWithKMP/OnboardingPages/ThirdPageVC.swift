//
//  ThirdPageVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 12/06/25.
//

import UIKit

class ThirdPageVC: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Onboarding Page 3")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.layer.borderColor = .none
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = .systemFont(ofSize: 18, weight: .bold)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    var animationHasBeenShown: Bool = false
    
    var portraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !(animationHasBeenShown){
            textLabel.animateLabelText(stringToAnimate: "Enjoy the real experience of life by reading books", delay: 0.06)
            animationHasBeenShown = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
    }

    func customize(){
        setUpView()
        addSubviewsToView()
        setConstraintsToSubviews()
        checkDeviceOrientation()
    }
    
    func setUpView(){
        view.backgroundColor = .systemBackground
    }
    
    func addSubviewsToView(){
        view.addSubview(imageView)
        view.addSubview(textLabel)
    }
    
    func setConstraintsToSubviews(){
        portraitConstraints = [
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 400),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)]
        
        landscapeConstraints = [
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 1),
            textLabel.widthAnchor.constraint(equalToConstant: 520),
            textLabel.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 420),
            imageView.heightAnchor.constraint(equalToConstant: 230),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40)]
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?){
        super.traitCollectionDidChange(previousTraitCollection)
        checkDeviceOrientation()
    }
    
    func checkDeviceOrientation() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        
        let currentOrientation = windowScene.interfaceOrientation
        if currentOrientation.isPortrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
            textLabel.font = .systemFont(ofSize: 18, weight: .bold)
        }
        else if currentOrientation.isLandscape {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
            textLabel.font = .systemFont(ofSize: 15, weight: .bold)
            
        }
    }
}
 
