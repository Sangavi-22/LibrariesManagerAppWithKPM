//
//  LibraryBooksCollectionTVCell.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

class LibraryBooksCollectionTVCell: UITableViewCell {
    
    static let cellIdentifier = "LibraryBooksCollectionTVCell"
    
    var library: Library?
    
    var parentVC: UIViewController?
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.dragDelegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BookCoverCollectionViewCell.self,
                                forCellWithReuseIdentifier: BookCoverCollectionViewCell.identifier)
        return collectionView
    }()
    
    var portraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.library = nil
        collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableViewCell(){
        customizeTableViewCell()
        addSubviewsToView()
        setConstraintsToSubviews()
    }
    
    func customizeTableViewCell(){
        contentView.backgroundColor = .systemBackground
    }
    
    func addSubviewsToView(){
        contentView.addSubview(collectionView)
    }
    
    func setConstraintsToSubviews(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)])
    }
    
}
