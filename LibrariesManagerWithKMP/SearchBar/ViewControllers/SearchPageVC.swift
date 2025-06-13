//
//  SearchPageVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import Combine
import KMPLibrariesManager

class SearchPageVC: UIViewController {
    
    let viewModel = SearchPageVM()
    
    private lazy var emptyDataHandler: SearchPageEmptyDataHandler = {
        let handler = SearchPageEmptyDataHandler()
        handler.setDataInSubviews(
            text: NSLocalizedString("common_no_results_found", comment: "No results found"),
            imageName: "magnifyingglass"
        )
        return handler
    }()

    var searchResults: [Book_] = [] {
        didSet {
            tableView.reloadData()

            tableView.backgroundView = (searchResults.isEmpty && !searchInput.isEmpty) ? emptyDataHandler : nil
        }
    }
    
    var searchInput: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("search_bar_placeholder", comment: "Search books, authors")
        searchBar.keyboardType = .webSearch
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .secondaryLabel
//        refreshControl.addTarget(self, action: #selector(pullToRefreshCalled()), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BooksInListingTableViewCell.self,
                           forCellReuseIdentifier: BooksInListingTableViewCell.cellIdentifier)
        tableView.frame = view.bounds
        tableView.refreshControl = refreshControl
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self 
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindViewModel()
    }
    
    func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        self.navigationItem.titleView = searchBar
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$searchResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.searchResults = result
            }
            .store(in: &cancellables)
    }
    
    @objc func pullToRefreshCalled(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}

extension SearchPageVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        self.searchInput = text
        viewModel.getSearchResults(for: text)
    }
}
