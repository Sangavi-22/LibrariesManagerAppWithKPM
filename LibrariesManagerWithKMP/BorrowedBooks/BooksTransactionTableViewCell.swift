//
//  BooksTransactionTableViewCell.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import UIKit
import KMPLibrariesManager

class BooksTransactionTableViewCell: UITableViewCell {
    
    static let identifier = "BooksTransactionTableViewCell"
    
    weak var parentVC: OrdersPlacedVC?
    
    lazy var bookImage: UIImageView = {
        let bookImage = UIImageView()
        bookImage.isUserInteractionEnabled = true
        bookImage.tintColor = .label
        
        bookImage.layer.shadowColor = UIColor.systemGray2.cgColor
        bookImage.layer.shadowOffset = CGSize(width: 2, height: 0)
        bookImage.layer.shadowOpacity = 1
        bookImage.layer.shadowRadius = 4
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(bookImageTapped))
        bookImage.addGestureRecognizer(tapGesture)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        return bookImage
    }()
    
    let bookTitleLabel: UILabel = {
        let bookTitleLabel = UILabel()
        bookTitleLabel.numberOfLines = 2
        bookTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        bookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return bookTitleLabel
    }()
    
    let userIdLabel: UILabel = {
        let userIdLabel = UILabel()
        userIdLabel.textColor = .systemGray
        userIdLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        userIdLabel.translatesAutoresizingMaskIntoConstraints = false
        return userIdLabel
    }()
    
    let borrowedDateLabel: UILabel = {
        let borrowedDateLabel = UILabel()
        borrowedDateLabel.font = .systemFont(ofSize: 15, weight: .regular)
        borrowedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return borrowedDateLabel
    }()
    
    let returnDateLabel: UILabel = {
        let returnDateLabel = UILabel()
        returnDateLabel.font = .systemFont(ofSize: 15, weight: .regular)
        returnDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return returnDateLabel
    }()
    
    let deliveryStatusLabel: UILabel = {
        let deliveryStatusLabel = UILabel()
        deliveryStatusLabel.font = .systemFont(ofSize: 16, weight: .medium)
        deliveryStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        return deliveryStatusLabel
    }()
    
    let labelImage: UIImageView = {
        let labelImage = UIImageView()
        labelImage.translatesAutoresizingMaskIntoConstraints = false
        return labelImage
    }()
    
    let enlargedImageVC = EnlargedBookCoverVC()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        changeShadowColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookTitleLabel.text = nil
        userIdLabel.text = nil
        borrowedDateLabel.text = nil
        returnDateLabel.text = nil
        deliveryStatusLabel.text = nil
        labelImage.image = nil
        bookImage.image = nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        changeShadowColor()
    }
    
    func changeShadowColor(){
        if traitCollection.userInterfaceStyle == .dark{
            bookImage.layer.shadowColor = UIColor.systemGray2.cgColor
        }
        else{
            bookImage.layer.shadowColor = UIColor.label.cgColor
        }
    }
    
    func setUp(){
        contentView.addSubview(bookTitleLabel)
        contentView.addSubview(borrowedDateLabel)
        contentView.addSubview(returnDateLabel)
        contentView.addSubview(deliveryStatusLabel)
        contentView.addSubview(labelImage)
        contentView.addSubview(bookImage)
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            bookImage.widthAnchor.constraint(equalToConstant: 110),
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            bookTitleLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 18),
            bookTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            userIdLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 18),
            userIdLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor),
            userIdLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            userIdLabel.heightAnchor.constraint(equalToConstant: 20),
            
            borrowedDateLabel.topAnchor.constraint(equalTo: userIdLabel.bottomAnchor),
            borrowedDateLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 18),
            borrowedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            borrowedDateLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
            
            returnDateLabel.topAnchor.constraint(equalTo: borrowedDateLabel.bottomAnchor),
            returnDateLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 18),
            returnDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            returnDateLabel.heightAnchor.constraint(equalToConstant: 25),
            
            labelImage.topAnchor.constraint(equalTo: returnDateLabel.bottomAnchor, constant: 10),
            labelImage.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 18),
            labelImage.widthAnchor.constraint(equalToConstant: 23.5),
            labelImage.heightAnchor.constraint(equalToConstant: 21),
            
            deliveryStatusLabel.topAnchor.constraint(equalTo: returnDateLabel.bottomAnchor, constant: 10),
            deliveryStatusLabel.leadingAnchor.constraint(equalTo: labelImage.trailingAnchor, constant: 2),
            deliveryStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deliveryStatusLabel.heightAnchor.constraint(equalToConstant: 21),
            
        ])
    }
    
    func configure(with order: OrderDetails_, and book: Book_, isOverDue: Bool){
        configureLabels(with: order, isOverDue: isOverDue)
        bookImage.image = UIImage(named: book.bookImage)
        bookTitleLabel.text = book.title
        userIdLabel.text = "User ID: \(order.userId)"
        enlargedImageVC.configure(with: UIImage(named: book.bookImage) ?? UIImage(systemName: "books.vertical.fill")!)
    }
    
    func configureLabels(with order: OrderDetails_, isOverDue: Bool){
        borrowedDateLabel.text = "Borrowed: \(order.dateBorrowed)"
        returnDateLabel.text = "Return: \(order.dateOfReturn)"
        
        if isOverDue {
            labelImage.tintColor = .systemRed
            labelImage.image = UIImage(systemName: "xmark.circle.fill")
            deliveryStatusLabel.text = "Overdue"
            deliveryStatusLabel.textColor = .systemRed
        } else {
            labelImage.tintColor = .systemTeal
            labelImage.image = UIImage(systemName: "book.closed.circle.fill")
            deliveryStatusLabel.text = "Borrowed"
            deliveryStatusLabel.textColor = .systemTeal
        }
    }
    
    @objc func bookImageTapped(){
        enlargedImageVC.modalPresentationStyle = .overFullScreen
        enlargedImageVC.modalTransitionStyle = .coverVertical
        self.parentVC?.present(enlargedImageVC, animated: true)
    }
}
    

