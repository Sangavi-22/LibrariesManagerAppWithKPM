//
//  EnlargedBookCoverVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

class EnlargedBookCoverVC: UIViewController {
    
    var portraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x: 30, y: 50, width: 50, height: 50)
        cancelButton.setImage(UIImage(systemName:"xmark"), for: .normal)
        cancelButton.tintColor = .label
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        return cancelButton
    }()
    
    let blurView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
    }
    
    func customize(){
        setUpView()
        addSubviewsAndSetConstraints()
        checkDeviceOrientation()
        addPinchGesture()
        addRotateGesture()
    }
    
    func setUpView(){
        view.insertSubview(blurView, at: 0)
        
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.direction = .down
        swipeGesture.addTarget(self, action: #selector(imageViewSwipedDown))
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func imageViewSwipedDown(){
        self.dismiss(animated: true)
    }
    
    func addSubviewsAndSetConstraints(){
        self.view.addSubview(imageView)
        self.view.addSubview(cancelButton)
        
        
        landscapeConstraints = [
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 280),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            cancelButton.widthAnchor.constraint(equalToConstant: 50),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)]
        
 
       portraitConstraints = [
        blurView.topAnchor.constraint(equalTo: view.topAnchor),
        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
        blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        imageView.widthAnchor.constraint(equalToConstant: 315),
        imageView.heightAnchor.constraint(equalToConstant: 450),
        
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        cancelButton.widthAnchor.constraint(equalToConstant: 70),
        cancelButton.heightAnchor.constraint(equalToConstant: 70)]
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?){
        super.traitCollectionDidChange(previousTraitCollection)
        checkDeviceOrientation()
    }
    
    
    func checkDeviceOrientation() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
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
    
    func addPinchGesture(){
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(imagePinched(_:)))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func imagePinched(_ sender: UIPinchGestureRecognizer){
        guard let bookImage = sender.view else{ return }
        bookImage.transform = bookImage.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    func addRotateGesture(){
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(imageRotationInitiated(_:)))
        imageView.addGestureRecognizer(rotateGesture)
    }

    @objc func imageRotationInitiated(_ sender: UIRotationGestureRecognizer){
        let rotation = sender.rotation
        let imageView = sender.view as! UIImageView
        let previousTransform = imageView.transform
        imageView.transform = CGAffineTransformRotate(previousTransform, rotation)
        sender.rotation = 0
    }
    
    func configure(with image: UIImage){
        imageView.image = image
    }
    
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        imageView.transform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0)
    }
    
}

