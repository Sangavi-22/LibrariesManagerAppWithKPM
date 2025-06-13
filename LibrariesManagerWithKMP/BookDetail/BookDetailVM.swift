//
//  BookDetailVM.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import KMPLibrariesManager

class BookDetailVM {
    
    func checkBookPresenceInWishList(book: Book_) -> Bool {
        do {
            let userId = UserDefaultsManager.retreiveString(for: .userIdOfAccount) ?? ""
            return try dataSource.getWishListItemsForUser(userId: userId).contains(where: {$0.bookId == book.id})
        } catch {
            return false
        }
    }
    
    func borrowBook(book: Book_) {
        do {
            let newStock = max(book.stockAvailable - 1, 0)

            // Create updated book instance with new stock
            let updatedBook = Book_(
                id: book.id,
                bookImage: book.bookImage,
                title: book.title,
                author: book.author,
                genre: book.genre,
                description: book.description,
                language: book.language,
                pagesCount: book.pagesCount,
                cost: book.cost,
                publishedDate: book.publishedDate,
                stockAvailable: newStock,
                bookReviews: book.bookReviews,
                libraryId: book.libraryId
            )
            
            let userId = UserDefaultsManager.retreiveString(for: .userIdOfAccount) ?? ""

            try dataSource.updateBook(book: updatedBook)

            // Create order details
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent formatting
            let borrowedDate = formatter.string(from: Date())
            let returnDate = formatter.string(from: Calendar.current.date(byAdding: .day, value: 15, to: Date())!)


            let dateBorrowed = "\(Date())"
            let dateOfReturn = "\(String(describing: Calendar.current.date(byAdding: .day, value: 15, to: Date())))"

            let order = OrderDetails_(
                orderId: 0,
                userId: userId,
                bookId: book.id,
                dateBorrowed: dateBorrowed,
                dateOfReturn: dateOfReturn
            )

            try dataSource.insertOrder(order: order)

        } catch {
            print("Error borrowing book: \(error)")
        }
    }
    
    func addToWishList(book: Book_) {
        do {
            let userId = UserDefaultsManager.retreiveString(for: .userIdOfAccount) ?? ""
            try dataSource.insertIntoWishList(userId: userId, bookId: book.id)
        } catch {
            print("Error while adding to wishlist")
        }
    }
    
    func removeFromWishList(book: Book_) {
        do {
            let userId = UserDefaultsManager.retreiveString(for: .userIdOfAccount) ?? ""
            try dataSource.removeFromWishList(userId: userId, bookId: book.id)
        } catch {
            print("Error while adding to wishlist")
        }
    }
    
    func getOrderDetails(of book: Book_) -> OrderDetails_? {
        do {
            let userId = UserDefaultsManager.retreiveString(for: .userIdOfAccount) ?? ""
            return try dataSource.getOrdersOfUser(userId: userId).first(where: {$0.bookId == book.id}) ?? nil
        } catch {
            print("Error while fetching")
            return nil
        }
    }
    
    func updateOrder(of book: Book_) {
        do {
            let dateBorrowed = "\(Date())"
            let dateOfReturn = "\(String(describing: Calendar.current.date(byAdding: .day, value: 15, to: Date())))"

            if let existingOrder = getOrderDetails(of: book) {
                let order = OrderDetails_(
                    orderId: existingOrder.orderId,
                    userId: existingOrder.userId,
                    bookId: existingOrder.bookId,
                    dateBorrowed: dateBorrowed,
                    dateOfReturn: dateOfReturn
                )
                try dataSource.updateOrder(order: order)
            }
            
        } catch {
            print("Error while updating order")
        }
    }
    
    func canBorrow(book: Book_) -> Bool {
        return getOrderDetails(of: book) == nil && book.stockAvailable > 0 
    }
    
    func getBook(with bookId: String) -> Book_? {
        do {
            return try dataSource.getAllBooks().first(where: {$0.id == bookId})
        } catch {
            return nil
        }
    }
    
    func fetchLibrary(with id: String) -> Library? {
        return try? dataSource.getAllLibraries().first(where: { $0.id == id })
    }
    

}
