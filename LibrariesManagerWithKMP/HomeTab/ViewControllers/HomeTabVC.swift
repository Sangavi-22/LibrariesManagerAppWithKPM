//
//  HomeTabVC.swift
//  LibrariesManagerAppWithKMP
//
//  Created by sangavi-15083 on 05/06/25.
//
import UIKit
import Combine
import KMPLibrariesManager
import SwiftUI

class HomeTabVC: UIViewController {
    
    private let viewModel = HomeTabVM()
    
    private var isInitialLoad = true
    
    var libraries: [Library] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(LibraryBooksCollectionTVCell.self,
                           forCellReuseIdentifier: LibraryBooksCollectionTVCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var shimmerViewController: UIHostingController<ShimmerView> = {
        let controller = UIHostingController(rootView: ShimmerView())
        controller.view.isHidden = true
        return controller
    }()
    
    private lazy var searchButton = UIBarButtonItem(barButtonSystemItem: .search,
                                                    target: self,
                                                    action: #selector(searchButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindViewModel()
        viewModel.fetchLibraries()
    }
    
    private func setUpView() {
        self.navigationItem.title = "Biblio"
        self.navigationController?.navigationBar.prefersLargeTitles = true 
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationItem.rightBarButtonItems = [searchButton]
        
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        self.view.addSubview(shimmerViewController.view)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$uiState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {
                case .loading:
                    if self.isInitialLoad {
                        self.showShimmer()
                    }

                case .success(let libraries):
                    self.libraries = libraries
                    self.tableView.reloadData()
                    self.hideShimmer()
                    self.isInitialLoad = false

                case .error(let message):
                    self.hideShimmer()
                    self.showToast(with: message)
                    self.isInitialLoad = false
                }
            }
            .store(in: &cancellables)
    }

    private func showShimmer() {
        shimmerViewController.view.frame = tableView.bounds
        tableView.isHidden = true
    }
    
    private func hideShimmer() {
        tableView.isHidden = false
    }
    
    private func showToast(with message: String) {
        let contentToShow = ToastViewContent(image: UIImage(systemName: "wrongwaysign"),
                                             title: message)
        self.showToast(with: contentToShow)
    }
    
    @objc private func searchButtonTapped() {
        let searchPageVC = SearchPageVC()
        self.navigationController?.pushViewController(searchPageVC, animated: true)
    }
    
}
