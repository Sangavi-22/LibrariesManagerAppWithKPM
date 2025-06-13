//
//  OrdersPlacedVC + TVDelegates.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

extension OrdersPlacedVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ordersCount = viewModel.getOrdersToReturn().count
        
        if ordersCount <= 0 {
            self.tableView.setEmptyView(text: "No orders found", imageName: "tray.full.fill")
        }
        else{
            self.tableView.restore()
        }
        return ordersCount
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BooksTransactionTableViewCell.identifier, for: indexPath) as! BooksTransactionTableViewCell
        let order = viewModel.getOrdersToReturn()[indexPath.row]
        if let book = viewModel.fetchBook(of: order) {
            cell.configure(with: order, and: book, isOverDue: viewModel.isOrderOverDue(order: order))
        }
        cell.parentVC = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 161
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
