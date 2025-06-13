//
//  BookCoverCollectionViewCell.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

class BookCoverCollectionViewCell: UICollectionViewCell{
    
    static let identifier = "BookCoverCollectionViewCell"
    
    let bookImageView: UIImageView = {
        let bookImageView = UIImageView()
        bookImageView.tintColor = .label
        bookImageView.layer.cornerRadius = 15
        bookImageView.clipsToBounds = true
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        return bookImageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionViewCell(){
        self.contentView.backgroundColor = .clear
        addSubviewsToView()
        setConstraintsToSubviews()
        
    }
    
    func addSubviewsToView(){
        contentView.addSubview(bookImageView)
    }
    
    func setConstraintsToSubviews(){
        NSLayoutConstraint.activate([
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    
    func configure(with book: Book_) {
        bookImageView.image = UIImage(named: book.bookImage)
    }
}
 

