//
//  HomeTabVC + TableViewDelegates.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit

extension HomeTabVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.libraries.count <= 0 {
            self.tableView.setEmptyView(text: NSLocalizedString("common_no_data", comment: "No data found"),
                                        imageName: "building.columns")
        } else {
            self.tableView.restore()
        }
        return self.libraries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LibraryBooksCollectionTVCell.cellIdentifier,
                                                 for: indexPath) as! LibraryBooksCollectionTVCell
        cell.userInteractionEnabledWhileDragging = true
        
        let library = self.libraries[indexPath.section]
        cell.parentVC = self
        cell.library = library
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = createAndCustomizeHeaderView(for: section)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleHeaderViewTap(_:)))
        headerView.addGestureRecognizer(tapGestureRecognizer)
        headerView.tag = section

        return headerView
    }
    
    func createAndCustomizeHeaderView(for section: Int) -> UIView{
        let headerView = UIView()
        headerView.frame.size = CGSize(width: self.tableView.frame.width,
                                       height: self.tableView.frame.width)
        headerView.backgroundColor = .systemBackground
        
        let library = self.libraries[section]
        
        let titleLabelForHeader = UILabel()
        titleLabelForHeader.textColor = .label
        titleLabelForHeader.font = .systemFont(ofSize: 19, weight: .bold)
        titleLabelForHeader.numberOfLines = 0
        titleLabelForHeader.text = library.name
        titleLabelForHeader.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabelForHeader = UILabel()
        subtitleLabelForHeader.textColor = .label
        subtitleLabelForHeader.font = .systemFont(ofSize: 15, weight: .light)
        subtitleLabelForHeader.numberOfLines = 0
        subtitleLabelForHeader.text = library.location
        subtitleLabelForHeader.translatesAutoresizingMaskIntoConstraints = false
        
        let seeAllLabel = UILabel()
        seeAllLabel.text = NSLocalizedString("see_all", comment: "See All")
        seeAllLabel.textColor = .systemBlue
        seeAllLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        seeAllLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(titleLabelForHeader)
        headerView.addSubview(seeAllLabel)
        headerView.addSubview(subtitleLabelForHeader)
        
        NSLayoutConstraint.activate([
            titleLabelForHeader.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            titleLabelForHeader.leadingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            seeAllLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            seeAllLabel.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        
            subtitleLabelForHeader.topAnchor.constraint(equalTo: seeAllLabel.bottomAnchor, constant: 10),
            subtitleLabelForHeader.leadingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            subtitleLabelForHeader.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            subtitleLabelForHeader.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15)])
        
        
        return headerView
    }

    @objc func handleHeaderViewTap(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else{
            return
        }
        
        let library = self.libraries[section]
        let bookListingVC = BooksListingVC(library: library)
        self.navigationController?.pushViewController(bookListingVC, animated: true)
    }
    
    
}

