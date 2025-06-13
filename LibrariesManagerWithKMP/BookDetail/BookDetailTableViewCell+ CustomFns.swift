//
//  BookDetailVC + CustomFns.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

extension BookDetailTableViewCell{
    
    func customize(){
        setUpView()
        addGestureToImageView()
        addSubviewsAndConstraints()
        setDataInSubviews()
        checkAndEnableGetButton()
        checkAndEnableWishListButton()
    }
    
    func setUpView(){
        self.selectionStyle = .none
    }
    
    func addGestureToImageView(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(imageViewTapped))
        bookImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageViewTapped(){
        let enlargedImageVC = EnlargedBookCoverVC()
        enlargedImageVC.configure(with: bookImage.image ?? .add)
        enlargedImageVC.modalPresentationStyle = .overFullScreen
        enlargedImageVC.modalTransitionStyle = .coverVertical
        parentVC?.present(enlargedImageVC, animated: true)
    }
    
    func addSubviewsAndConstraints(){
        contentView.addSubview(bookImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(starRating)
        contentView.addSubview(reviewsCount)
        contentView.addSubview(wishListButton)
        contentView.addSubview(stockAvailabilityIndicator)
        contentView.addSubview(getButton)
        contentView.addSubview(lineBelowGetButton)
        contentView.addSubview(bookDescriptionTitleLabel)
        contentView.addSubview(bookDescription)
        contentView.addSubview(lineBelowBookDescriptionLabel)
        contentView.addSubview(bookAdditionalInfoView)
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            bookImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookImage.widthAnchor.constraint(equalToConstant: 240),
            bookImage.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            authorNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            starRating.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 20),
            starRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            starRating.widthAnchor.constraint(equalToConstant: 100),
            starRating.heightAnchor.constraint(equalToConstant: 20),
            
            reviewsCount.topAnchor.constraint(equalTo: starRating.bottomAnchor, constant: 4),
            reviewsCount.leadingAnchor.constraint(equalTo: starRating.leadingAnchor),
            reviewsCount.trailingAnchor.constraint(equalTo: starRating.trailingAnchor),
            reviewsCount.heightAnchor.constraint(equalToConstant: 15),
            
            wishListButton.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 20),
            wishListButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            wishListButton.widthAnchor.constraint(equalToConstant: 150),
            wishListButton.heightAnchor.constraint(equalToConstant: 40),
            
            stockAvailabilityIndicator.topAnchor.constraint(equalTo: wishListButton.bottomAnchor, constant: 10),
            stockAvailabilityIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stockAvailabilityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stockAvailabilityIndicator.heightAnchor.constraint(equalToConstant: 40),
            
            getButton.topAnchor.constraint(equalTo: stockAvailabilityIndicator.bottomAnchor, constant: 10),
            getButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            getButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            getButton.heightAnchor.constraint(equalToConstant: 44),
            
            lineBelowGetButton.topAnchor.constraint(equalTo: getButton.bottomAnchor, constant: 20),
            lineBelowGetButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            lineBelowGetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            lineBelowGetButton.heightAnchor.constraint(equalToConstant: 2),
            
            bookDescriptionTitleLabel.topAnchor.constraint(equalTo: lineBelowGetButton.bottomAnchor, constant: 10),
            bookDescriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bookDescriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bookDescriptionTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            bookDescription.topAnchor.constraint(equalTo: bookDescriptionTitleLabel.bottomAnchor),
            bookDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bookDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            lineBelowBookDescriptionLabel.topAnchor.constraint(equalTo: bookDescription.bottomAnchor, constant: 20),
            lineBelowBookDescriptionLabel.heightAnchor.constraint(equalToConstant: 2),
            lineBelowBookDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            lineBelowBookDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            bookAdditionalInfoView.topAnchor.constraint(equalTo: lineBelowBookDescriptionLabel.bottomAnchor),
            bookAdditionalInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            bookAdditionalInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            bookAdditionalInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            ])
    }
    
    
    func setDataInSubviews(){
        guard let book = book else{
            return
        }
        bookImage.image = UIImage(named: book.bookImage) ?? UIImage(systemName: "book.closed")
        titleLabel.text = book.title
        authorNameLabel.text = book.author
        stockAvailabilityIndicator.text = "Stock available: \(book.stockAvailable)"
        bookDescription.text = book.description_
        starRating.configure(with: book.bookReviews)
        
        let bookReviewsCount = book.bookReviews.count
        if bookReviewsCount <= 1{
            reviewsCount.text = "\(bookReviewsCount) Review"
        }
        else{
            reviewsCount.text = "\(bookReviewsCount) Reviews"
        }
        
        bookAdditionalInfoView.configure(with: book,
                                         and: libraryName)
    }
    
    func checkAndEnableGetButton(){
        
        guard let book = book else {
            return
        }
        
        let canBorrow = viewModel.canBorrow(book: book)
        if canBorrow {
            getButton.setTitle("Get", for: .normal)
            getButton.isEnabled = true
            stockAvailabilityIndicator.textColor = .label
            borrow = false
        } else {
            getButton.setTitle("Get", for: .normal)
            getButton.isEnabled = false
            stockAvailabilityIndicator.textColor = .label
            borrow = false
        }
    }
    
    func checkAndEnableWishListButton(){
        guard let book = book else{
            return
        }
        let bookPresent = viewModel.checkBookPresenceInWishList(book: book)
        if bookPresent{
            wishListButton.setImage(UIImage(systemName: "star.slash.fill"), for: .normal)
            wishListButton.imageView?.tintColor = .systemPink
            wishListButton.setTitle(" Remove", for: .normal)
            addBooks = false
        }
        else{
            wishListButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            wishListButton.imageView?.tintColor = .systemIndigo
            wishListButton.setTitle(" Add", for: .normal)
            addBooks = true
        }
    }
    
    @objc func getButtonTapped(){
        if borrow == true{
            confirmBorrowBook()
        }
        else if borrow == false{
            confirmRenewBook()
        }
    }
    
    func confirmBorrowBook(){
        let alertController = UIAlertController(title: "Borrow Book Confirmation", message: "Confirm if you want to borrow this book", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) {(result: UIAlertAction) -> Void in
            self.placeOrder()
        }
        
        let no = UIAlertAction(title: "No", style: .destructive)

        alertController.addAction(no)
        alertController.addAction(yes)
        
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.contentView
            popoverPresentationController.sourceRect = self.contentView.bounds
            popoverPresentationController.permittedArrowDirections = []
        }
        
        self.parentVC?.present(alertController, animated: true)
    }
    
    func placeOrder(){
        if let book = book {
            viewModel.borrowBook(book: book)
            self.parentVC?.showToast(with: ToastViewContent(image: UIImage(systemName: "checkmark.diamond.fill"),
                                                            title: "Borrowed book"
                                                           ))
            self.parentVC?.tableView.reloadData()
        }
    }
    
    func confirmRenewBook(){
        let alertController = UIAlertController(title: "Renew Book confirmation", message: "Confirm if you want to renew this book", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) {(result: UIAlertAction) -> Void in
            self.renewOrder()
        }
        let no = UIAlertAction(title: "No", style: .destructive)

        alertController.addAction(no)
        alertController.addAction(yes)
        
        if let popoverPresentationController = alertController.popoverPresentationController {
                popoverPresentationController.sourceView = self.contentView
                popoverPresentationController.sourceRect = self.contentView.bounds
                popoverPresentationController.permittedArrowDirections = []
        }

        self.parentVC?.present(alertController, animated: true)
    }
    
    func renewOrder(){
        if let book = book {
            viewModel.updateOrder(of: book)
            self.parentVC?.showToast(with: ToastViewContent(image: UIImage(systemName: "checkmark.diamond.fill"),
                                                            title: "Renewed order"))
            self.parentVC?.tableView.reloadData()
        }
    }
    
    @objc func wishListButtonTapped(){
        if addBooks{
            addToWishList()
        }
        else{
            removeFromWishList()
        }
        checkAndEnableWishListButton()
    }
    
    func addToWishList(){
        if let book = book{
            viewModel.addToWishList(book: book)
            self.parentVC?.showToast(with: ToastViewContent(image: UIImage(systemName: "star.fill"), title: "Added to wishlist"))
        }
    }
    
   func removeFromWishList(){
       if let book = book{
           viewModel.removeFromWishList(book: book)
           self.parentVC?.showToast(with: ToastViewContent(image: UIImage(systemName: "star.slash.fill"), title: "Removed from wishlist"))
       }
    }
    
}


