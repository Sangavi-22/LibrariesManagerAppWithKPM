//
//  LandingPageVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 12/06/25.
//

import UIKit

class LandingPageVC: UIViewController {
    
    let pageViewController = ScrollablePageVC(transitionStyle: .scroll,
                                              navigationOrientation: .horizontal)
    
    lazy var signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.systemOrange, for: .normal)
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor.systemOrange.cgColor
        signUpButton.layer.cornerRadius = 20
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        return signUpButton
    }()
    
    lazy var signInButton: CustomButton = {
        let signInButton = CustomButton()
        signInButton.configuration?.title = "Sign In"
        signInButton.configuration?.cornerStyle = .capsule
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return signInButton
    }()
    
    var portraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?){
       super.traitCollectionDidChange(previousTraitCollection)
        checkDeviceOrientation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        setUpView()
        configureAndAddSubviews()
        addConstraintsToSubViews()
        checkDeviceOrientation()
    }
    
    func setUpView() {
        view.backgroundColor = .systemBackground
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    func configureAndAddSubviews() {
        view.addSubview(pageViewController.view)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        
        pageViewController.view?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addConstraintsToSubViews() {
        portraitConstraints = [
            pageViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: pageViewController.view.bottomAnchor, constant: 10),
            signInButton.widthAnchor.constraint(equalToConstant: 340),
            signInButton.heightAnchor.constraint(equalToConstant: 44),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalToConstant: 340),
            signUpButton.heightAnchor.constraint(equalToConstant: 44)]
        
        landscapeConstraints = [
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            pageViewController.view.widthAnchor.constraint(equalToConstant: 500),
            
            signInButton.leadingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor, constant: 10),
            signInButton.heightAnchor.constraint(equalToConstant: 44),
            signInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            signInButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),
            signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            signUpButton.leadingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor, constant: 10)]
                                
    }
    
    func checkDeviceOrientation() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        
        let currentOrientation = windowScene.interfaceOrientation
        if currentOrientation.isPortrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        }
        else if currentOrientation.isLandscape {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        }
    }
    
    @objc func signUpButtonTapped() {
        switchToSignIn(choice: false)
    }
    
    @objc func signInButtonTapped() {
        switchToSignIn(choice: true)
    }
    
    func switchToSignIn(choice: Bool) {
//        if choice {
//            let signInPageVC = createInstanceOfSignInPage()
//            let navController = UINavigationController(rootViewController: signInPageVC)
//            self.present(navController, animated: true)
//        }
//        else {
//            let signUpPageVC = createInstanceOfSignUpPage()
//            let navController = UINavigationController(rootViewController: signUpPageVC)
//            self.present(navController, animated: true)
//        }
    }
    
//    func createInstanceOfSignUpPage() -> SignUpFormVC{
//        let signUpPage = SignUpFormVC()
//        signUpPage.parentVC = self
//        return signUpPage
//    }
//    
//    func createInstanceOfSignInPage() -> SignInPageVC{
//        let signInPage = SignInPageVC()
//        signInPage.parentVC = self
//        return signInPage
//    }
}

