//
//  ListViewController.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 09.04.2023.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: - Private variables
    private var movieViewModel = MovieViewModel()
    private var favListArray: [Result] = []

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
        movieViewModel.callService { [weak self] isSuccess in
            guard let sSelf = self else { return }

            if isSuccess {
                sSelf.reloadData()
            }
        }
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
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}


// MARK: - @objc private extension
@objc private extension ListViewController {

    func cellLongPressed(_ gesture: UILongPressGestureRecognizer) {
        guard let cell = gesture.view as? UITableViewCell else { return }

        switch gesture.state {
        case .began:
            // Обработка начала долгого нажатия на ячейку
            guard let indexPath = tableView.indexPath(for: cell),
                  let item = movieViewModel.movieModel()?.results[indexPath.row] else { return }

            // Добавление или удаление элемента из массива фаворитов
            if favListArray.contains(where: { $0 == item }) {
                favListArray.removeAll(where: { $0 == item })
            } else {
                favListArray.append(item)
            }
            // Сохранение массива фаворитов
            // Преобразование массива объектов Result в массив словарей
            let resultDictArray = favListArray.map { result -> [String: Any] in
                return [
                    "adult": result.adult,
                    "backdropPath": result.backdropPath,
                    "genreIDS": result.genreIDS,
                    "id": result.id,
                    "originalLanguage": result.originalLanguage,
                    "originalTitle": result.originalTitle,
                    "overview": result.overview,
                    "popularity": result.popularity,
                    "posterPath": result.posterPath,
                    "releaseDate": result.releaseDate,
                    "title": result.title,
                    "video": result.video,
                    "voteAverage": result.voteAverage,
                    "voteCount": result.voteCount
                ]
            }
            // Сохранение преобразованного массива в UserDefaults
            UserDefaults.standard.set(resultDictArray, forKey: Constants.UserDefaults.favouritesList)
        default:
            break
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
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed(_:)))
        guard let model = movieViewModel.movieModel() else { return UITableViewCell()}

        cell.addGestureRecognizer(longPressGesture)
        cell.configurationCell(model, indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
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
