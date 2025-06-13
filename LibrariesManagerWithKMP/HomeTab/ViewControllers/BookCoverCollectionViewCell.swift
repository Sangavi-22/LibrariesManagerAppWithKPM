//
//  BookCoverCollectionViewCell.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

class BookCoverCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCoverCollectionViewCell"
    
    let bookImageView: UIImageView = {
        let bookImageView = UIImageView()
        bookImageView.tintColor = .label
        bookImageView.layer.cornerRadius = 15
        bookImageView.clipsToBounds = true
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        return bookImageView
    }()
    
    private let topRatedBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.9)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.isHidden = true // initially hidden
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.text = "★ Top Rated"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        topRatedBadgeView.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionViewCell() {
        self.contentView.backgroundColor = .clear
        addSubviewsToView()
        setConstraintsToSubviews()
    }
    
    func addSubviewsToView() {
        contentView.addSubview(bookImageView)
        bookImageView.addSubview(topRatedBadgeView)
        topRatedBadgeView.addSubview(badgeLabel)
    }
    
    func setConstraintsToSubviews() {
        NSLayoutConstraint.activate([
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            topRatedBadgeView.topAnchor.constraint(equalTo: bookImageView.topAnchor, constant: 6),
            topRatedBadgeView.trailingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: -6),

            badgeLabel.topAnchor.constraint(equalTo: topRatedBadgeView.topAnchor, constant: 4),
            badgeLabel.bottomAnchor.constraint(equalTo: topRatedBadgeView.bottomAnchor, constant: -4),
            badgeLabel.leadingAnchor.constraint(equalTo: topRatedBadgeView.leadingAnchor, constant: 6),
            badgeLabel.trailingAnchor.constraint(equalTo: topRatedBadgeView.trailingAnchor, constant: -6)
        ])
    }
    
    func configure(with book: Book_) {
        bookImageView.image = UIImage(named: book.bookImage)
        
        let isTopRated = book.stockAvailable <= 1 ? true : false 
        topRatedBadgeView.isHidden = !isTopRated
    }
}

