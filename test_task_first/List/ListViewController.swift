//
//  ListViewController.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 09.04.2023.
//

import UIKit

class ListViewController: UIViewController {

    private var movieViewModel = MovieViewModel()

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
private extension ListViewController {

    func setupUI() {
        setupnNvigationController()
        movieViewModel.callService()
        setupTableView()
    }

    func setupnNvigationController() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.isOpaque = true
        navigationItem.title = Constants.Text.list
        navigationController.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = Constants.Text.list
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        reloadData()
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieViewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell

        guard let model = movieViewModel.movieModel() else { return UITableViewCell()}
        cell.configurationCell(model, indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = self.navigationController else { return }
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        if let model = movieViewModel.movieModel() {
            controller.movieModel = model
        }
        controller.indexPath = indexPath
        navController.pushViewController(controller, animated: true)
    }

}
