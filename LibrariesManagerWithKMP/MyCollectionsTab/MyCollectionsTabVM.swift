//
//  MyCollectionsTabVM.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import KMPLibrariesManager

class MyCollectionsTabVM {
    func getBooksToReturn() -> [Book_] {
        do {
            let userId = UserDefaultsManager.retreiveString(for: .userIdOfAccount) ?? ""
            let orderedBooks = try dataSource.getOrdersOfUser(userId: userId).map{$0.bookId}
            let allBooks = try dataSource.getAllBooks()
            return allBooks.filter { orderedBooks.contains($0.id) }
        } catch {
            return []
        }
    }
    
    func getWishListedBooks() -> [Book_] {
        guard let userId = UserDefaultsManager.retreiveString(for: .userIdOfAccount), !userId.isEmpty else {
            print("User ID not found")
            return []
        }
        do {
            let wishListBookIds = try dataSource.getWishListedBookIds(userId: userId)
            let allBooks = try dataSource.getAllBooks()
            return allBooks.filter { wishListBookIds.contains($0.id) }
        } catch {
            print("Failed to fetch wishlisted books: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchLibrary(with id: String) -> Library? {
        return try? dataSource.getAllLibraries().first(where: { $0.id == id })
    }
    
    func fetchBook(of order: OrderDetails_) -> Book_? {
        return try? dataSource.getAllBooks().first(where: {$0.id == order.bookId})
    }
}
