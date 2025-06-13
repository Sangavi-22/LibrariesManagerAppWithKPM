//
//  SearchPageVC + TableViewDelegates.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import UIKit

extension SearchPageVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BooksInListingTableViewCell.cellIdentifier,
                                                 for: indexPath) as! BooksInListingTableViewCell
        
        let book = self.searchResults[indexPath.row]
        cell.configure(with: book)
        cell.isFromSearchResults = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = self.searchResults[indexPath.row]
        let bookDetailVC = BookDetailVC(book: book, library: viewModel.getLibrary(with: book.libraryId))
        self.navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}

