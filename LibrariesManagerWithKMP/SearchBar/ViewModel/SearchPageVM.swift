//
//  SearchPageVM.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import Combine
import KMPLibrariesManager

class SearchPageVM: ObservableObject {
    
    @Published private(set) var searchResults: [Book_] = []
    
    func getSearchResults(for searchInput: String){
        do {
            var searchResults: [Book_] = []
            try getAllBooks().forEach{ book in
                let bookMatches = compareDetails(of: book, with: searchInput)
                if bookMatches{
                    searchResults.append(book)
                }
            }
            self.searchResults = searchResults
            
        } catch {
            self.searchResults = []
        }
    }
    
    func getLibrary(with id: String) -> Library? {
        return try? dataSource.getAllLibraries().first(where: { $0.id == id })
    }
    
    private func getAllBooks() throws -> [Book_] {
        try dataSource.getAllBooks()
    }
     
    private func compareDetails(of book: Book_, with searchInput: String) -> Bool{
        let input = searchInput.lowercased()
        let bookMatches: Bool = book.title.lowercased().contains(input) ||
                                book.author.lowercased().contains(input)
        return bookMatches
    }
    
    
}
