//
//  BooksListingVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

class BooksListingVC: UIViewController {
    
    let library: Library
    
    init(library: Library) {
        self.library = library
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .secondaryLabel
        refreshControl.addTarget(self, action: #selector(tableViewRefreshing), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BooksInListingTableViewCell.self,
                           forCellReuseIdentifier: BooksInListingTableViewCell.cellIdentifier)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    let notificationName = Notification.Name("review")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = library.name
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: notificationName, object: nil)
    }
    
    @objc func tableViewRefreshing(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func handleNotification(_ notification: Notification){
        self.tableView.reloadData()
    }
    
}

extension BooksListingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let booksCount = self.library.books.count
        if booksCount <= 0 {
            self.tableView.setEmptyView(text: NSLocalizedString("common_no_data", comment: "No data found"),
                                        imageName: "books.vertical.fill")
        } else {
            self.tableView.restore()
        }
        return booksCount
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: BooksInListingTableViewCell.cellIdentifier,
                                                 for: indexPath) as! BooksInListingTableViewCell
        cell.configureWithBook(at: indexPath.row,
                       from: library)
        cell.parentVC = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = library.books[indexPath.row]
        let bookDetailVC = BookDetailVC(book: book, library: library)
        self.navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}

