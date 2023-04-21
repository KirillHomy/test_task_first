//
//  TabBarViewController.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 09.04.2023.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)

        setupTabBarStyle()
    }

}

// MARK: - Private extension
private extension TabBarController {
    
    func setupUI() {
        // List
        let listStoryboard = UIStoryboard(name: "List", bundle: nil)
        let list: ListViewController = listStoryboard.instantiateViewController(identifier: "ListViewController")
        let listNav = UINavigationController(rootViewController: list)
        listNav.tabBarItem = UITabBarItem(title: Constants.Text.list,
                                          image: UIImage(systemName: "list.bullet"),
                                          selectedImage: UIImage(systemName: "list.number"))

        // Favourites
        let favouritesStoryboard = UIStoryboard(name: "Favourites", bundle: nil)
        let favourites: FavouritesViewController = favouritesStoryboard.instantiateViewController(identifier: "FavouritesViewController")
        let favouritesNav = UINavigationController(rootViewController: favourites)
        favouritesNav.tabBarItem = UITabBarItem(title: Constants.Text.favourites,
                                                image: UIImage(systemName: "star"),
                                                selectedImage: UIImage(systemName: "star.fill"))

        setViewControllers([listNav, favouritesNav], animated: false)
        selectedViewController = listNav
        setupTabBarStyle()
    }

    func setupTabBarStyle() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.lightGray

        // Removing the strip above tabbar
        appearance.shadowImage = nil
        appearance.shadowColor = nil

        // Set color to inactive tabBatItem
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]

        // Set appearance
        self.tabBar.standardAppearance = appearance

        // Set color to active tabBatItem
        self.tabBar.tintColor = .systemBlue

        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }
    }

}
