//
//  SignInPageVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

class SignInPageVC: UIViewController{
    
    var userAccount: User?

    weak var parentVC: LandingPageVC?
    
    let viewModel = SignInPageVM()
    
    let scrollView = CustomScrollView()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Biblio"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 30)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    let floatingEmailIdFieldLabel: CustomFieldLabel = {
        let label = CustomFieldLabel()
        label.text = "Email Id"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    lazy var emailIdField: UITextField = {
        let emailIdField = UITextField()
        emailIdField.attributedPlaceholder = NSAttributedString(string: "Enter your email address", attributes: [
            .foregroundColor: UIColor.tertiaryLabel,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        emailIdField.tag = 0
        emailIdField.keyboardType = .emailAddress
        emailIdField.clearButtonMode = .whileEditing
        emailIdField.autocapitalizationType = .none
        emailIdField.autocorrectionType = .no
        emailIdField.delegate = self
        emailIdField.translatesAutoresizingMaskIntoConstraints = false
        return emailIdField
    }()

    let emailIdFieldUnderLine = CustomViewForUnderLiningFields()

    let emailIdFieldErrorLabel: CustomErrorLabel = {
        let label = CustomErrorLabel()
        label.text = "Required"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    let floatingPasswordLabel: CustomFieldLabel = {
        let label = CustomFieldLabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()

    lazy var passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.setUpPasswordField()
        passwordField.attributedPlaceholder = NSAttributedString(string: "Enter your password", attributes: [
            .foregroundColor: UIColor.tertiaryLabel,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        passwordField.backgroundColor = .systemBackground
        passwordField.layer.borderWidth = 0
        passwordField.leftViewMode = .never
        passwordField.tag = 1
        passwordField.delegate = self
        return passwordField
    }()

    let passwordUnderLine = CustomViewForUnderLiningFields()

    let passwordErrorLabel: CustomErrorLabel = {
        let label = CustomErrorLabel()
        label.text = "Required"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    lazy var signInButton: CustomButton = {
        let signInButton = CustomButton()
        signInButton.configuration?.title = "Sign In"
        signInButton.layer.cornerRadius = 25
        signInButton.isEnabled = false
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return signInButton
    }()
    
    lazy var closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))

    lazy var navBarSignUpButton = UIBarButtonItem(title: "Sign Up", style: .plain, target: self, action: #selector(signUpButtonTapped))

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        emailIdField.text?.removeAll()
        emailIdFieldErrorLabel.alpha = 0
        emailIdFieldUnderLine.backgroundColor = UIColor.secondarySystemBackground

        passwordField.text?.removeAll()
        passwordErrorLabel.alpha = 0
        passwordUnderLine.backgroundColor = UIColor.secondarySystemBackground

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailIdField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure(){
        setupView()
        setUpPresentationControllerDelegate()
        addSubviews()
        addCustomSpacingAfterSubviews()
        setConstraintsToSubviews()
        setUpKeyboardHandling()
    }

    func setupView(){
        view.backgroundColor = .systemBackground
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = navBarSignUpButton
    }
    
    func setUpPresentationControllerDelegate(){
        navigationController?.presentationController?.delegate = self
        isModalInPresentation = true
    }

    func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(floatingEmailIdFieldLabel)
        stackView.addArrangedSubview(emailIdField)
        stackView.addArrangedSubview(emailIdFieldUnderLine)
        stackView.addArrangedSubview(emailIdFieldErrorLabel)
        
        stackView.addArrangedSubview(floatingPasswordLabel)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(passwordUnderLine)
        stackView.addArrangedSubview(passwordErrorLabel)
        
        stackView.addArrangedSubview(signInButton)
        
    }
    
    func addCustomSpacingAfterSubviews(){
        stackView.setCustomSpacing(40, after: titleLabel)
        stackView.setCustomSpacing(10, after: emailIdFieldErrorLabel)
        stackView.setCustomSpacing(20, after: passwordErrorLabel)
    }

    func setConstraintsToSubviews(){

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            
            floatingEmailIdFieldLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 21),
            floatingEmailIdFieldLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -21),
            
            emailIdField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            emailIdField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            emailIdField.heightAnchor.constraint(equalToConstant: 44),
            
            emailIdFieldUnderLine.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            emailIdFieldUnderLine.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            emailIdFieldUnderLine.heightAnchor.constraint(equalToConstant: 1),
            
            emailIdFieldErrorLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 21),
            emailIdFieldErrorLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -21),
            emailIdFieldErrorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            floatingPasswordLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 21),
            floatingPasswordLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -21),
            
            passwordField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordUnderLine.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            passwordUnderLine.heightAnchor.constraint(equalToConstant: 1),
            
            passwordErrorLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            passwordErrorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            signInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func signInButtonPressed(){

        let passwordVerificationSuccess = verifyPasswordFieldTextAndTakeAction()

        if passwordVerificationSuccess{
            setDataInUserDefaults()
            let tabBarController = MainTabBarController()
            tabBarController.modalPresentationStyle = .fullScreen
            self.view.window?.rootViewController = tabBarController
            self.view.window?.makeKeyAndVisible()
        }

    }

    func setDataInUserDefaults(){
        guard let account = userAccount else {return}
        UserDefaultsManager.saveToUserDefaults(key: .userIdOfAccount, value: account.userId)
        UserDefaultsManager.saveToUserDefaults(key: .loggedIn, value: true)
    }

    @objc func signUpButtonTapped(){
        self.view.endEditing(true)
        self.dismiss(animated: true)
        parentVC?.switchToSignIn(choice: false)
    }
    
    @objc func closeButtonTapped(){
        let emailId = emailIdField.text ?? ""
        let password = passwordField.text ?? ""
        
        if !(emailId.isEmpty) || !(password.isEmpty){
            let alertController = UIAlertController(title: "Are you sure you want to go back?", message: nil, preferredStyle: .alert)
            
            let goBack = UIAlertAction(title: "Leave page", style: .destructive) { [weak self](result: UIAlertAction) -> Void in
                self?.dismiss(animated: true)
            }
            
            let continueEditing = UIAlertAction(title: "Continue Editing", style: .cancel)
            
            alertController.addAction(goBack)
            alertController.addAction(continueEditing)
            
            self.present(alertController, animated: true)
        }
        else{
            self.dismiss(animated: true)
        }
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetTextFieldAndErrorLabel(emailIdField)
        resetTextFieldAndErrorLabel(passwordField)
    }
}


extension SignInPageVC: UIAdaptivePresentationControllerDelegate{
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        closeButtonTapped()
    }
}


extension SignInPageVC{

    func setUpKeyboardHandling(){
        let dismissKeyboardTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnView))
        view.addGestureRecognizer(dismissKeyboardTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIsHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIsShown), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func handleTapOnView() {
        view.endEditing(true)
    }

    
    @objc func keyboardIsHidden(notification: Notification){
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    
    @objc func keyboardIsShown(notification: Notification){
        // When keyboard is shown alter the content inset of scroll as below
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        // scrollview's bottom anchor would be at the position of totalViewHeight - keyboardFrameHeight
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom + 7, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

}

extension SignInPageVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeScrollPosition(using: textField)
        resetTextFieldAndErrorLabel(textField)
    }
    
    func changeScrollPosition(using textField: UITextField){
        /* This fn is particularly helpful in landscape mode when the textField did begin editing the field below the currently active textField will not be visible in most of the cases. This fns brings the scroll view to a position where both the currently active field and field below it are visible on screen
         */
        var rect: CGRect = textField.bounds
        switch textField.tag{
        case 0:
            rect = passwordField.convert(passwordField.bounds, to: scrollView)
        case 1:
            rect = signInButton.convert(signInButton.bounds, to: scrollView)
        default:
            rect = textField.bounds
        }
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    func resetTextFieldAndErrorLabel(_ textField: UITextField){
        if textField.tag == emailIdField.tag {
            emailIdFieldErrorLabel.alpha = 0
            emailIdFieldUnderLine.backgroundColor = .label
        }
        else if textField.tag == passwordField.tag {
            passwordErrorLabel.alpha = 0
            passwordUnderLine.backgroundColor = .label
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        changeFocusTo(textField)
        checkAndChangePasswordTextFieldColor(textField)
        let canEnableSignInButton: Bool = verifyAllTextFieldEntryCompletion()
        signInButton.isEnabled = canEnableSignInButton
    }
    
    func changeFocusTo(_ textField: UITextField){
        let textFieldRect = textField.convert(.init(x: textField.bounds.minX, y: textField.bounds.maxY - 90, width: textField.bounds.width, height: textField.bounds.height), to: scrollView)
        scrollView.scrollRectToVisible(textFieldRect, animated: true)
        textField.becomeFirstResponder()
    }
    
    func checkAndChangePasswordTextFieldColor(_ textField: UITextField){
        if textField.tag == passwordField.tag{
            passwordErrorLabel.alpha = 0
            passwordUnderLine.backgroundColor = .label
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == emailIdField.tag {
            emailIdFieldUnderLine.backgroundColor = .secondarySystemBackground
            verifyEmailIdFieldTextAndTakeAction()
        }
        else if textField.tag == passwordField.tag{
            passwordUnderLine.backgroundColor = .secondarySystemBackground
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // When clear button is tapped in the textfield this fn is invoked
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return true
    }
    
    func verifyAllTextFieldEntryCompletion() -> Bool {
        let emailId = emailIdField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let accountPresent: User? = viewModel.getParticularAccount(emailId)
        
        return !(emailId.isEmpty) && !(password.isEmpty) && accountPresent != nil
    }
    
}
 

extension SignInPageVC{
    func verifyEmailIdFieldTextAndTakeAction() {
        guard let emailId = emailIdField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        
        let validationStatus: Result<User, EmailIdError> = viewModel.verify(emailId: emailId)
        switch validationStatus{
        case .success(let receivedAccount):
            userAccount = receivedAccount
            emailIdFieldErrorLabel.alpha = 0
            emailIdFieldUnderLine.backgroundColor = .secondarySystemBackground
            
        case .failure(let error):
            if error == EmailIdError.empty{
                emailIdFieldErrorLabel.alpha = 0
                emailIdFieldUnderLine.backgroundColor = .secondarySystemBackground
                signInButton.isEnabled = false
            }
            else{
                emailIdFieldErrorLabel.text = error.rawValue
                emailIdFieldErrorLabel.alpha = 1
                emailIdFieldUnderLine.backgroundColor = UIColor.red
                signInButton.isEnabled = false
            }
        }
    }
    
    
    func verifyPasswordFieldTextAndTakeAction() -> Bool{
        guard let userAccount = userAccount else{
            return false
        }
        
        guard let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return false
        }
        
        let passwordVerificationStatus: Result<Bool, PasswordVerificationError> = viewModel.verify(password, with: userAccount)
        
        switch passwordVerificationStatus {
        case .success:
            passwordErrorLabel.alpha = 0
            passwordUnderLine.backgroundColor = .secondarySystemBackground
            return true
            
        case .failure(let error):
            if error == PasswordVerificationError.empty{
                passwordErrorLabel.alpha = 0
                passwordUnderLine.backgroundColor = .secondarySystemBackground
                signInButton.isEnabled = false
            }
            else{
                passwordErrorLabel.text = error.rawValue
                passwordErrorLabel.alpha = 1
                passwordUnderLine.backgroundColor = UIColor.red
                signInButton.isEnabled = false
            }
        }
        return false
    }
}

enum EmailIdError: String, Error{
    case empty = "Field is empty"
    case invalid = "Invalid email address"
    case redundant = "Email address present already"
    case emailIdNotFound = "Sorry, account not found"
}


