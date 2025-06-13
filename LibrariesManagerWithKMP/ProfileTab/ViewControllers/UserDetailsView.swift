//
//  UserDetailsView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

class UserDetailsView: UIView {
    
    let emailIdView = ViewWithTitleAndContentFields()
    let nameView = ViewWithTitleAndContentFields()
    
    private var commonConstraints: [NSLayoutConstraint] = []
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameView, emailIdView])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateForCurrentOrientation()
        setLabelAlignment()
        updateUIStyle()
    }

    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(stackView)
        setupConstraints()
        updateForCurrentOrientation()
        setLabelAlignment()
        updateUIStyle()
    }

    private func setupConstraints() {
        // Common: aligning subviews inside stack
        commonConstraints = [
            nameView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            emailIdView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            emailIdView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ]
        
        // Portrait layout using layoutMarginsGuide
        portraitConstraints = [
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10)
        ]
        
        // Landscape layout using layoutMarginsGuide
        landscapeConstraints = [
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
            stackView.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor, constant: 70),
            stackView.widthAnchor.constraint(equalToConstant: 350),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10)
        ]
    }

    private func updateForCurrentOrientation() {
        NSLayoutConstraint.deactivate(commonConstraints + portraitConstraints + landscapeConstraints)
        NSLayoutConstraint.activate(commonConstraints)

        let isPortrait = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? true
        if isPortrait {
            NSLayoutConstraint.activate(portraitConstraints)
            stackView.axis = .vertical
            stackView.spacing = 20
        } else {
            NSLayoutConstraint.activate(landscapeConstraints)
            stackView.axis = .vertical
            stackView.spacing = 20 // You could make this 10 if you want reduced spacing in landscape
        }
    }

    private func setLabelAlignment() {
        let isPortrait = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? true
        let alignment: NSTextAlignment = isPortrait ? .right : .left
        emailIdView.contentLabel.textAlignment = alignment
        nameView.contentLabel.textAlignment = alignment
    }

    private func updateUIStyle() {
        backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .secondarySystemBackground : .systemBackground
    }

    func configure(with account: User) {
        emailIdView.configure(with: "mail", and: "Email", also: account.emailId.isEmpty ? "-" : account.emailId)
        nameView.configure(with: "person", and: "Name", also: account.name.isEmpty ? "-" : account.name)
    }
}
