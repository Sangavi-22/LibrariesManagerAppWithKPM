//
//  MyCollectionTabVC + CollectionViewDelegates.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

extension MyCollectionsTabVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var booksCount = 0
        
        let selectedIndex = segmentedControl.selectedSegmentIndex
        switch selectedIndex{
        case 0:
            booksCount = viewModel.getBooksToReturn().count
        default:
            booksCount = viewModel.getWishListedBooks().count
        }
        handleEmptyDataAfterChecking(booksCount)
        
        return booksCount
    }
    
    func handleEmptyDataAfterChecking(_ booksCount: Int){
        if booksCount <= 0 {
            self.collectionView.setEmptyView(text: "No books found", imageName:  "books.vertical.fill")
        }
        else{
            self.collectionView.restore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCoverCollectionViewCell.identifier, for: indexPath) as! BookCoverCollectionViewCell
        let book = rowsToDisplay[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let book = rowsToDisplay[indexPath.row]
        if let library = viewModel.fetchLibrary(with: book.libraryId) {
            let bookDetailVC = BookDetailVC(book: book, library: library)
            self.navigationController?.pushViewController(bookDetailVC, animated: true)
        }
        
    }

}

