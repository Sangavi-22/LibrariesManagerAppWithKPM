//
//  LibraryBooksCollectionTVCell + CollectionViewDelegate.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

extension LibraryBooksCollectionTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.library?.books.count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCoverCollectionViewCell.identifier,
                                                      for: indexPath) as! BookCoverCollectionViewCell
        if let book = self.library?.books[indexPath.row] {
            cell.configure(with: book)
        }
        cell.backgroundColor = .systemBackground
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let book = self.library?.books[indexPath.row] {
            let bookDetailVC = BookDetailVC(book: book, library: library)
        }
    }
}


