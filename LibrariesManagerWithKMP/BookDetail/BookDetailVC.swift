//
//  BookDetailVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import UIKit
import KMPLibrariesManager

class BookDetailVC: UIViewController {
    var book: Book_?
    var library: Library?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.frame = view.frame
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BookDetailTableViewCell.self,
                           forCellReuseIdentifier: BookDetailTableViewCell.cellIdentifier)
        return tableView
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    private lazy var shareLinkButton = UIBarButtonItem(title: nil,
                                               image: UIImage(systemName: "square.and.arrow.up"),
                                               target: self,
                                               action: #selector(shareBook))
    
    let notificationName = Notification.Name("review")
    
    let viewModel = BookDetailVM() 
    
    init(book: Book_?, library: Library?) {
        self.book = book
        self.library = library
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame.size = CGSize(width: view.frame.width + 500, height: view.frame.height + 700)
        self.tableView.frame = view.frame
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        checkUIStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNavBar()
        addNotificationObserver()
        checkUIStyle()
    }
    
    private func setUpView(){
        self.navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func setUpNavBar(){
        self.navigationItem.rightBarButtonItem = shareLinkButton
    }
    
    private func addNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: notificationName, object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification){
        self.tableView.reloadData()
    }
    
    private func checkUIStyle(){
        if traitCollection.userInterfaceStyle == .dark{
            self.gradientLayer.colors = [UIColor.secondarySystemFill.cgColor,  UIColor.secondarySystemBackground.cgColor, UIColor.systemBackground.cgColor]
            self.gradientLayer.locations = [0.0, 0.11, 0.20]
        }
        else{
            self.gradientLayer.colors = [UIColor.systemBackground.cgColor]
        }
        
    }
    
    @objc func shareBook(){
        let message = String(format: NSLocalizedString("share_book_message", comment: ""), book?.title ?? "")
        let url = URL(string: "bookStore://Book_\(String(describing: book?.id))")
        self.presentSheet(with: message, and: url)
    }
    
    func presentSheet(with text: String, and url: URL?){
        guard let url = url else { return }
        
        let shareSheetVC = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
        
        self.present(shareSheetVC, animated: true)
    }
    
    func reloadAllData() {
        self.book = viewModel.getBook(with: book?.id ?? "")
        self.library = viewModel.fetchLibrary(with: book?.libraryId ?? "")
        self.tableView.reloadData()
    }
}

extension BookDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookDetailTableViewCell.cellIdentifier,
                                                 for: indexPath) as! BookDetailTableViewCell
        cell.libraryName = library?.name ?? ""
        cell.configure(with: book)
        cell.parentVC = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return UITableView.automaticDimension
        }
        let currentOrientation = windowScene.interfaceOrientation
        
        if currentOrientation.isPortrait{
            return 1040
        }
        else{
            return 855
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
