//
//  OrdersPlacedVM.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import Foundation
import KMPLibrariesManager
class OrdersPlacedVM {
    
    func getOrdersToReturn() -> [OrderDetails_] {
        do {
            let userId = UserDefaultsManager.retreiveString(for: .userIdOfAccount) ?? ""
            return try dataSource.getAllOrders().filter{ $0.userId == userId }
        } catch {
            print("Failed to fetch orders: \(error)")
            return []
        }
    }
    
    func isOrderOverDue(order: OrderDetails_) -> Bool {
        if let returnDate = Date(from: order.dateOfReturn) {
            return returnDate < Date()
        }
        return false
    }
    
    func fetchBook(of order: OrderDetails_) -> Book_? {
        do {
            return try dataSource.getAllBooks().first(where: {$0.id == order.bookId})
        } catch {
            return nil
        }
    }

}
