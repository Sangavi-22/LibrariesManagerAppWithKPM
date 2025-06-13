//
//  LibraryListingTableViewCell.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 09/06/25.
//

import UIKit

class LibraryListingTableViewCell: UITableViewCell {
    
    static let identifier = "LibraryListingTableViewCell"
    
    private(set) var topRatedList = false
    
    private lazy var libraryCoverImage: UIImageView = {
        let libraryCoverImage = UIImageView()
        libraryCoverImage.clipsToBounds = true
        libraryCoverImage.translatesAutoresizingMaskIntoConstraints = false
        return libraryCoverImage
    }()
    
    private lazy var libraryNameLabel: UILabel = {
        let libraryNameLabel = UILabel()
        return libraryNameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews(for topRatedList: Bool) {
        self.topRatedList = topRatedList
    }
    
    private func setupCell() {
        if topRatedList {
            
        } else {
            contentView.addSubview(libraryCoverImage)
            contentView.addSubview(libraryNameLabel)
        }
    }
    
    
}
