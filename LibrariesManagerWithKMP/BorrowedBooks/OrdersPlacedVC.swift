//
//  OrdersPlacedVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import UIKit

class OrdersPlacedVC: UIViewController {
    
    var returnDateFilterEnabled = false
    
    let viewModel = OrdersPlacedVM() 
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(BooksTransactionTableViewCell.self,
                           forCellReuseIdentifier: BooksTransactionTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
    }
    
    func customize(){
        setUp()
        addSubviewsToView()
        setConstraintsToSubviews()
    }
     
    func setUp(){
        view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func addSubviewsToView(){
        view.addSubview(tableView)
    }
    
    func setConstraintsToSubviews(){
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    

}
 


