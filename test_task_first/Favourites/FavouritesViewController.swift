//
//  FavouritesViewController.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 09.04.2023.
//

import UIKit

class FavouritesViewController: UIViewController {

    // MARK: - Pravate IBOutlet
     @IBOutlet private weak var tableView: UITableView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupnNvigationController()
    }

}

// MARK: - Private extension
private extension FavouritesViewController {

    func setupUI() {
        setupnNvigationController()
        setupTableView()
    }

    func setupnNvigationController() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.isOpaque = true
        navigationItem.title = Constants.Text.favourites
        navigationController.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = Constants.Text.favourites
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        reloadData()
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

}
