//
//  MainTabBarController.swift
//  LibrariesManagerAppWithKMP
//
//  Created by sangavi-15083 on 05/06/25.
//
import UIKit

class MainTabBarController: UITabBarController {
    
    private lazy var homeTabBarItem: UINavigationController = {
        let homeTabBarItem = UINavigationController(rootViewController: HomeTabVC())
        homeTabBarItem.tabBarItem.image = UIImage(systemName: "house.fill")
        homeTabBarItem.title = NSLocalizedString("tabBar_home", comment: "Home")
        return homeTabBarItem
    }()
    
    private lazy var myCollectionsTabBarItem: UINavigationController = {
        let myCollectionsTabBarItem = UINavigationController(rootViewController: MyCollectionsTabVC())
        myCollectionsTabBarItem.tabBarItem.image = UIImage(systemName: "books.vertical.fill")
        myCollectionsTabBarItem.title = NSLocalizedString("tabBar_collections", comment: "Collections")
        return myCollectionsTabBarItem
    }()
    
    private lazy var profileTabBarItem: UINavigationController = {
        let profileTabBarItem = UINavigationController(rootViewController: ProfileTabVC())
        profileTabBarItem.tabBarItem.image = UIImage(systemName: "person.circle.fill")
        profileTabBarItem.title = NSLocalizedString("tabBar_profile", comment: "Profile")
        return profileTabBarItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        self.view.backgroundColor = .systemBackground
        
        changeTabBarAppearance()
        addTabBarItems()
    }
    
    private func setBackgroundColor(){
        self.view.backgroundColor = .systemBackground
    }
    
    private func changeTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.label]
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = attributes
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .label
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    private func addTabBarItems() {
        let tabBarItems = [homeTabBarItem, myCollectionsTabBarItem, profileTabBarItem]
        self.setViewControllers(tabBarItems, animated: true)
    }
}
