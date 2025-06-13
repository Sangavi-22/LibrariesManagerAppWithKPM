//
//  BookDetailTableViewCell.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

enum TransactionErrors: String, Error{
    case stockUnavailable = "Sorry stock unavailable"
    case maxTransactionLimitExceeded = "Max transaction limit crossed"
    case previouslyBorrowedButCanRenew = "Already Borrowed but can renew"
    case previouslyBorrowedAndCannotRenew = "Book previously borrowed"
}

class BookDetailTableViewCell: UITableViewCell {
    
    weak var parentVC: BookDetailVC?
    
    var book: Book_?
    var libraryName: String = ""
    
    static let cellIdentifier = "BookDetailTableViewCell"
    
    let viewModel = BookDetailVM()
    
    var addBooks: Bool = true
    var borrow: Bool?
    
    let bookImage: UIImageView = {
        let bookImage = UIImageView()
        bookImage.tintColor = .label
        bookImage.isUserInteractionEnabled = true
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        return bookImage
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
     let authorNameLabel: UILabel = {
        let authorNameLabel = UILabel()
        authorNameLabel.textAlignment = .center
         authorNameLabel.font = .systemFont(ofSize: 19, weight: .semibold)
         authorNameLabel.textColor = .secondaryLabel
        authorNameLabel.numberOfLines = 0
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return authorNameLabel
    }()
    
    lazy var ratings: UIView = {
        let ratings = UIView()
        let tapGesture = UITapGestureRecognizer()
        ratings.addGestureRecognizer(tapGesture)
        ratings.translatesAutoresizingMaskIntoConstraints = false
        return ratings
    }()
    
    lazy var starRating: StarRatingView = {
        let starRating = StarRatingView()
        let tapGesture = UITapGestureRecognizer()
        starRating.addGestureRecognizer(tapGesture)
        starRating.translatesAutoresizingMaskIntoConstraints = false
        return starRating
    }()
    
    let reviewsCount: UILabel = {
        let reviewsCount = UILabel()
        reviewsCount.textAlignment = .center
        reviewsCount.font = .systemFont(ofSize: 12, weight: .medium)
        reviewsCount.translatesAutoresizingMaskIntoConstraints = false
        return reviewsCount
    }()

    lazy var wishListButton = {
        let wishListButton = UIButton()
//        wishListButton.setTitle("\u{002B} Want To Read", for: .normal)
//        wishListButton.setTitle("\u{002D} Remove from wishlist", for: .normal)
        wishListButton.layer.cornerRadius = 20
        wishListButton.titleLabel?.textAlignment = .center
        wishListButton.backgroundColor = .label
        wishListButton.setTitleColor(.systemBackground, for: .normal)
        wishListButton.translatesAutoresizingMaskIntoConstraints = false
        wishListButton.addTarget(self, action: #selector(wishListButtonTapped), for: .touchUpInside)
        return wishListButton
    }()
    
    let stockAvailabilityIndicator: UILabel = {
        let stockAvailabilityIndicator = UILabel()
        stockAvailabilityIndicator.font = .systemFont(ofSize: 17, weight: .semibold)
        stockAvailabilityIndicator.textAlignment = .center
        stockAvailabilityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return stockAvailabilityIndicator
    }()
    
    lazy var getButton = {
        let getButton = UIButton()
        getButton.configuration = .filled()
        getButton.configuration?.baseBackgroundColor = .label
        getButton.configuration?.baseForegroundColor = .systemBackground
        getButton.configuration?.cornerStyle = .capsule
        getButton.setTitle("Get", for: .normal)
        getButton.addTarget(self, action: #selector(getButtonTapped), for: .touchUpInside)
        getButton.translatesAutoresizingMaskIntoConstraints = false
        return getButton
    }()
    
    let lineBelowGetButton = CustomViewForUnderLiningFields()
    
    let bookDescriptionTitleLabel: UILabel = {
        let bookDescriptionTitleLabel = UILabel()
        bookDescriptionTitleLabel.text = "Description: "
        bookDescriptionTitleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        bookDescriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return bookDescriptionTitleLabel
    }()
    
    let bookDescription: UILabel = {
        let bookDescription = UILabel()
        bookDescription.numberOfLines = 4
        bookDescription.font = .systemFont(ofSize: 15)
        bookDescription.translatesAutoresizingMaskIntoConstraints = false
        return bookDescription
    }()
    
    
    let lineBelowBookDescriptionLabel = CustomViewForUnderLiningFields()
    
    let bookAdditionalInfoView: BookAdditionalInfoView = {
        let bookAdditionalInfoView = BookAdditionalInfoView()
        bookAdditionalInfoView.translatesAutoresizingMaskIntoConstraints = false
        return bookAdditionalInfoView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .clear
        bookImage.image = nil
        titleLabel.text = nil
        authorNameLabel.text = nil
        stockAvailabilityIndicator.text = nil
        bookDescriptionTitleLabel.text = nil
        bookDescription.text = nil
        reviewsCount.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wishListButton.layer.borderColor = UIColor.label.cgColor
        bookDescriptionTitleLabel.textColor = .label
        bookDescriptionTitleLabel.text = "Description: "
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with book: Book_?){
        guard let book = book else{
            return
        }
        self.book = book
        customize()
    }

}


