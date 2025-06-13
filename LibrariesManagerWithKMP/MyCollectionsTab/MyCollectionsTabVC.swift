//
//  MyCollectionsTabVC.swift
//  LibrariesManagerAppWithKMP
//
//  Created by sangavi-15083 on 05/06/25.
//

import UIKit

class MyCollectionsTabVC: UIViewController{
    
    lazy var rowsToDisplay = viewModel.getBooksToReturn() 
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Yet to Return", "Wishlist"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .orange
        segmentedControl.addTarget(self, action: #selector(handleSegmentedChange), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width/3) - 30, height: (view.frame.size.width / 3) + 30)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return layout
    }()
     
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(BookCoverCollectionViewCell.self, forCellWithReuseIdentifier: BookCoverCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var paddedStackView: UIStackView = {
        let paddedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        paddedStackView.isLayoutMarginsRelativeArrangement = true
        paddedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 6, right: 12)
        return paddedStackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [paddedStackView, collectionView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var emptyDataHandlingView = EmptyDataView()
    
    let viewModel = MyCollectionsTabVM()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleSegmentedChange()
    }
    
    @objc func handleSegmentedChange(){
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            rowsToDisplay = viewModel.getBooksToReturn()
        default:
            rowsToDisplay = viewModel.getWishListedBooks()
        }
        self.collectionView.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        checkDeviceOrientation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
    }
    
    func customize(){
        setUpView()
        addSubviewsToView()
        setConstraints()
        checkDeviceOrientation()
    }
    
    func setUpView(){
        view.backgroundColor = .systemBackground
        title = "My Collections"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func addSubviewsToView(){
        view.addSubview(stackView)
        stackView.setCustomSpacing(10, after: paddedStackView)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    func checkDeviceOrientation(){
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let currentOrientation = windowScene.interfaceOrientation
        
        if currentOrientation.isPortrait {
            layout.itemSize = CGSize(width: (self.view.frame.width/3) - 15, height: (view.frame.size.width / 3) + 22)
            layout.minimumInteritemSpacing = 6
            layout.minimumLineSpacing = 10
        }
        else if currentOrientation.isLandscape {
            layout.itemSize = CGSize(width: (self.view.frame.width / 5) - 25, height: (self.view.frame.width / 5) + 20)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 20
        }
    }

}


