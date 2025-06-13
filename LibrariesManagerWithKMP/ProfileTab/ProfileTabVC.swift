//
//  ProfileTabVC.swift
//  LibrariesManagerAppWithKMP
//
//  Created by sangavi-15083 on 05/06/25.
//
import UIKit

class ProfileTabVC: UIViewController {
    
    var editProfile = false
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var profilePicture: CustomProfilePic = {
        let profilePicture = CustomProfilePic(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(changeProfilePicture))
        profilePicture.addGestureRecognizer(tapGesture)
        return profilePicture
    }()
    
    lazy var editIcon: UIImageView = {
        let editIcon = UIImageView()
        editIcon.image = UIImage(systemName: "camera.circle.fill")
        editIcon.tintColor = .darkGray
        editIcon.backgroundColor = .link
        editIcon.layer.cornerRadius = 25
        editIcon.clipsToBounds = false
        editIcon.translatesAutoresizingMaskIntoConstraints = false
        return editIcon
    }()
    
    lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        return imagePickerController
    }()
    
    lazy var imagePreviewItem = ImagePreviewItem()
    
    let userDetailsView: UserDetailsView = {
        let userDetailsView = UserDetailsView()
        userDetailsView.backgroundColor = .systemBackground
        userDetailsView.layer.cornerRadius = 10
        userDetailsView.translatesAutoresizingMaskIntoConstraints = false
        return userDetailsView
    }()
    
    lazy var ordersPlaced: UIButton = {
        let ordersPlaced = UIButton(type: .system)
        ordersPlaced.frame.size = CGSize(width: 200, height: 50)
        ordersPlaced.setTitle("View orders placed ", for: .normal)
        ordersPlaced.setTitleColor(.label, for: .normal)
        ordersPlaced.backgroundColor = .systemBackground
        ordersPlaced.layer.cornerRadius = 10
        ordersPlaced.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        ordersPlaced.addTarget(self, action: #selector(viewOrdersPlaced), for: .touchUpInside)
        ordersPlaced.translatesAutoresizingMaskIntoConstraints = false
        return ordersPlaced
    }()
    
    
    lazy var changePasswordButton: UIButton = {
        let changePasswordButton = UIButton(type: .system)
        changePasswordButton.frame.size = CGSize(width: 200, height: 50)
        changePasswordButton.setTitle("Change password", for: .normal)
        changePasswordButton.setTitleColor(.label, for: .normal)
        changePasswordButton.backgroundColor = .systemBackground
        changePasswordButton.layer.cornerRadius = 10
        changePasswordButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        changePasswordButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        return changePasswordButton
    }()
    
    lazy var deleteAccountButton: UIButton = {
        let deleteAccountButton = UIButton(type: .system)
        deleteAccountButton.frame.size = CGSize(width: 200, height: 50)
        deleteAccountButton.setTitle("Delete Account ", for: .normal)
        deleteAccountButton.setTitleColor(.systemRed, for: .normal)
        deleteAccountButton.backgroundColor = .systemBackground
        deleteAccountButton.layer.cornerRadius = 10
        deleteAccountButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        deleteAccountButton.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteAccountButton
    }()

    lazy var signOutButton: UIButton = {
        let signOutButton = UIButton(type: .system)
        signOutButton.frame.size = CGSize(width: 200, height: 50)
        signOutButton.setTitle("Sign out ", for: .normal)
        signOutButton.setTitleColor(.label, for: .normal)
        signOutButton.backgroundColor = .systemBackground
        signOutButton.layer.cornerRadius = 10
        signOutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        return signOutButton
    }()
    
    lazy var passwordField = UITextField()
    lazy var confirmPasswordField = UITextField()
    
    lazy var photoManager: PhotoManager = {
        let photoManager = PhotoManager()
        photoManager.delegate = self
        return photoManager
    }()
    
    let notificationName = Notification.Name("editedProfile")
    
    let viewModel = ProfileTabVM() 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSubviewWithData()
    }
    
    func configureSubviewWithData(){
        if let account = viewModel.getUserDetails() {
            userDetailsView.configure(with: account)
            profilePicture.image = UIImage(systemName: "person.circle")!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleBackgroundChange()
        customize()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        handleBackgroundChange()
    }
    
    func handleBackgroundChange(){
        if traitCollection.userInterfaceStyle == .dark{
            view.backgroundColor = .systemBackground
            userDetailsView.backgroundColor = .secondarySystemBackground
            ordersPlaced.backgroundColor = .secondarySystemBackground
            changePasswordButton.backgroundColor = .secondarySystemBackground
            deleteAccountButton.backgroundColor = .secondarySystemBackground
            signOutButton.backgroundColor = .secondarySystemBackground
        }
        else{
            view.backgroundColor = .secondarySystemBackground
            userDetailsView.backgroundColor = .systemBackground
            ordersPlaced.backgroundColor = .systemBackground
            changePasswordButton.backgroundColor = .systemBackground
            deleteAccountButton.backgroundColor = .systemBackground
            signOutButton.backgroundColor = .systemBackground
        }
    }
    
    func customize(){
        addSubviewsForUserAcc()
        addCustomSpacingAfterSubviewsForUserAcc()
        setConstraintsForUserAcc()
        setUpNavBar()
        addNotificationObserver()
        addTapGestureToView()
    }
    
    private func addSubviewsForUserAcc(){
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        profilePicture.addSubview(editIcon)
        stackView.addArrangedSubview(profilePicture)
        stackView.addArrangedSubview(userDetailsView)
        stackView.addArrangedSubview(ordersPlaced)
        stackView.addArrangedSubview(changePasswordButton)
        stackView.addArrangedSubview(deleteAccountButton)
        stackView.addArrangedSubview(signOutButton)
    }
    
    private func addCustomSpacingAfterSubviewsForUserAcc(){
        stackView.setCustomSpacing(20, after: profilePicture)
        stackView.setCustomSpacing(10, after: userDetailsView)
        stackView.setCustomSpacing(10, after: ordersPlaced)
        stackView.setCustomSpacing(10, after: changePasswordButton)
        stackView.setCustomSpacing(10, after: deleteAccountButton)
    }
    
    private func setConstraintsForUserAcc(){
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
         
        NSLayoutConstraint.activate([
            editIcon.trailingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: -8.9),
            editIcon.widthAnchor.constraint(equalToConstant: 30),
            editIcon.heightAnchor.constraint(equalToConstant: 30),
            editIcon.bottomAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: -15),
            
            profilePicture.heightAnchor.constraint(equalToConstant: 120),
            profilePicture.widthAnchor.constraint(equalToConstant: 120),
            profilePicture.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            userDetailsView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            userDetailsView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            userDetailsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            ordersPlaced.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            ordersPlaced.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            ordersPlaced.heightAnchor.constraint(equalToConstant: 50),
            
            changePasswordButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            changePasswordButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 50),
            
            deleteAccountButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            deleteAccountButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            signOutButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    private func setUpNavBar(){
        title = "Account"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: notificationName, object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        // Update your view controller with the changes made in the first view controller
        configureSubviewWithData()
        
    }
    
    func addTapGestureToView(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(dismissPresentedView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissPresentedView(){
        self.dismiss(animated: true)
    }
    
    @objc func viewOrdersPlaced(){
        let ordersPlacedVC = OrdersPlacedVC()
        self.navigationController?.pushViewController(ordersPlacedVC, animated: true)
    }
    
    @objc func signOutTapped(){
        let alertController = UIAlertController(title: "Signout Confirmation", message: "Do you want to sign out of account?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) {(result: UIAlertAction) -> Void in
            self.goOutOfAccount()
        }
        
        let noAction = UIAlertAction(title: "No", style: .default){(result: UIAlertAction) -> Void in
            print()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true)
    }
    
    func goOutOfAccount(){
        let navigationController = UINavigationController(rootViewController: LandingPageVC())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

}



