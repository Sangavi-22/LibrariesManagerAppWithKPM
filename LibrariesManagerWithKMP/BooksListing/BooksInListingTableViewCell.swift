//
//  BooksInListingTableViewCell.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.

import UIKit
import KMPLibrariesManager

class BooksInListingTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "BooksInListingTableViewCell"
    
    weak var parentVC: UIViewController?
    
    lazy var bookImageView: UIImageView = {
        let bookImageView = UIImageView()
        bookImageView.tintColor = .label
        bookImageView.isUserInteractionEnabled = true
        
        bookImageView.layer.shadowColor = UIColor.systemGray2.cgColor
        bookImageView.layer.shadowOffset = CGSize(width: 2, height: 0)
        bookImageView.layer.shadowOpacity = 1
        bookImageView.layer.shadowRadius = 4
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(bookImageTapped))
        bookImageView.addGestureRecognizer(tapGesture)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        return bookImageView
    }()
    
    let libraryName: UILabel = {
        let libraryName = UILabel()
        libraryName.textColor = .red
        libraryName.textAlignment = .left
        libraryName.numberOfLines = 1
        libraryName.font = .systemFont(ofSize: 20, weight: .bold)
        libraryName.translatesAutoresizingMaskIntoConstraints = false
        return libraryName
     }()
    
   let bookTitleLabel: UILabel = {
        let bookTitleLabel = UILabel()
        bookTitleLabel.textColor = .label
        bookTitleLabel.textAlignment = .left
        bookTitleLabel.numberOfLines = 2
       bookTitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        bookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return bookTitleLabel
    }()
    
    let bookAuthorNameLabel: UILabel = {
        let bookAuthorNameLabel = UILabel()
        bookAuthorNameLabel.textColor = .secondaryLabel
        bookAuthorNameLabel.textAlignment = .left
        bookAuthorNameLabel.adjustsFontSizeToFitWidth = true
        bookAuthorNameLabel.numberOfLines = 0
        bookAuthorNameLabel.font = .systemFont(ofSize: 15, weight: .medium)
        bookAuthorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return bookAuthorNameLabel
    }()
     
   let stockAvailabilityIndicator: UILabel = {
       let stockAvailabilityIndicator = UILabel()
       stockAvailabilityIndicator.textColor = .secondaryLabel
       stockAvailabilityIndicator.textAlignment = .left
       stockAvailabilityIndicator.font = .systemFont(ofSize: 15, weight: .regular)
       stockAvailabilityIndicator.translatesAutoresizingMaskIntoConstraints = false
       return stockAvailabilityIndicator
    }()
    
    lazy var starRating: StarRatingView = {
        let starRating = StarRatingView()
        starRating.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
//        tapGesture.addTarget(self, action: #selector(starRatingTapped))
        starRating.addGestureRecognizer(tapGesture)
        starRating.translatesAutoresizingMaskIntoConstraints = false
        return starRating
    }()
    
    let reviewsCount: UILabel = {
        let reviewsCount = UILabel()
        reviewsCount.textColor = .label
        reviewsCount.translatesAutoresizingMaskIntoConstraints = false
        return reviewsCount
    }()
    
    lazy var enlargedImageVC = EnlargedBookCoverVC()
    
    var isFromSearchResults: Bool = false
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        bookTitleLabel.text = nil
        bookAuthorNameLabel.text = nil
        stockAvailabilityIndicator.text = nil
        reviewsCount.text = nil
        isFromSearchResults = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        changeShadowColor()
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        changeShadowColor()
    }
    
    func changeShadowColor(){
        if traitCollection.userInterfaceStyle == .dark{
            bookImageView.layer.shadowColor = UIColor.systemGray2.cgColor
        }
        else{
            bookImageView.layer.shadowColor = UIColor.label.cgColor
        }
    }
    
    func setUp(){
        self.selectionStyle = .gray
        addSubviewsToView()
        setUpConstraints()
    }
    
    func addSubviewsToView(){
        if isFromSearchResults {
            contentView.addSubview(libraryName)
        } else {
            libraryName.removeFromSuperview()
        }
        contentView.addSubview(bookImageView)
        contentView.addSubview(bookTitleLabel)
        contentView.addSubview(bookAuthorNameLabel)
        contentView.addSubview(stockAvailabilityIndicator)
        contentView.addSubview(starRating)
        contentView.addSubview(reviewsCount)
    }
    
    func setUpConstraints(){
        if isFromSearchResults {
            NSLayoutConstraint.activate([
                libraryName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                libraryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                libraryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                libraryName.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
                
                bookImageView.topAnchor.constraint(equalTo: libraryName.bottomAnchor, constant: 10),
                bookImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                bookImageView.widthAnchor.constraint(equalToConstant: 117),
                bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                
                bookTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15),
                bookTitleLabel.topAnchor.constraint(equalTo: libraryName.topAnchor, constant: 10),
                bookTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                bookTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
                
                bookAuthorNameLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15),
                bookAuthorNameLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor),
                bookAuthorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                bookAuthorNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
                
                stockAvailabilityIndicator.topAnchor.constraint(equalTo: bookAuthorNameLabel.bottomAnchor),
                stockAvailabilityIndicator.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15),
                stockAvailabilityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                stockAvailabilityIndicator.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
                
                starRating.topAnchor.constraint(equalTo: stockAvailabilityIndicator.bottomAnchor, constant: 10),
                starRating.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15),
                starRating.widthAnchor.constraint(equalToConstant: 100),
                starRating.heightAnchor.constraint(equalToConstant: 20),
                
                reviewsCount.topAnchor.constraint(equalTo: stockAvailabilityIndicator.bottomAnchor, constant: 10),
                reviewsCount.leadingAnchor.constraint(equalTo: starRating.trailingAnchor, constant: 5),
                reviewsCount.widthAnchor.constraint(equalToConstant: 150),
                reviewsCount.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            bookImageView.widthAnchor.constraint(equalToConstant: 117),
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            bookTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15),
            bookTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            bookAuthorNameLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15),
            bookAuthorNameLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor),
            bookAuthorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookAuthorNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
            
            stockAvailabilityIndicator.topAnchor.constraint(equalTo: bookAuthorNameLabel.bottomAnchor),
            stockAvailabilityIndicator.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15),
            stockAvailabilityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stockAvailabilityIndicator.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
            
            starRating.topAnchor.constraint(equalTo: stockAvailabilityIndicator.bottomAnchor, constant: 10),
            starRating.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15),
            starRating.widthAnchor.constraint(equalToConstant: 100),
            starRating.heightAnchor.constraint(equalToConstant: 20),
            
            reviewsCount.topAnchor.constraint(equalTo: stockAvailabilityIndicator.bottomAnchor, constant: 10),
            reviewsCount.leadingAnchor.constraint(equalTo: starRating.trailingAnchor, constant: 5),
            reviewsCount.widthAnchor.constraint(equalToConstant: 150),
            reviewsCount.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureWithBook(at index: Int,
                           from library: Library) {
        let book = library.books[index]
        if libraryName.superview != nil {
            libraryName.text = library.name
        }
        configure(with: book)
    }
    
    func configure(with book: Book_) {
        bookImageView.image = UIImage(named: book.bookImage)
        bookTitleLabel.text = book.title
        bookAuthorNameLabel.text = book.author
        stockAvailabilityIndicator.text = "Stock: \(book.stockAvailable)"
        reviewsCount.text = "(\(book.bookReviews.count))"
        enlargedImageVC.configure(with: (bookImageView.image ?? UIImage(systemName: "book.closed"))!)
    }
    
    @objc func bookImageTapped(){
        enlargedImageVC.modalPresentationStyle = .overFullScreen
        enlargedImageVC.modalTransitionStyle = .coverVertical
        self.parentVC?.present(enlargedImageVC, animated: true)
    }
    
}
