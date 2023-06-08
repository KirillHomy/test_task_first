//
//  FavouritesViewController.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 09.04.2023.
//

import UIKit

class FavouritesViewController: UIViewController {

    // MARK: - Interface constants
    private var tableView = UITableView()

    // MARK: -  Private variables
    private var favListArray: [Result] = []

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupnNvigationController()
        getFavList()
    }

}

// MARK: - Private extension
private extension FavouritesViewController {

    func setupUI() {
        setupnNvigationController()
        setupTableView()
        setupViewColor()
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
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.register(FavouritesTableViewCell.nib(), forCellReuseIdentifier: "FavouritesTableViewCell")
        view.addSubview(tableView)
    }

    func setupViewColor() {
        view.backgroundColor = .systemBackground
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func getFavList() {
        // Извлечение массива словарей из UserDefaults
        if let resultDictArray = UserDefaults.standard.array(forKey: Constants.UserDefaults.favouritesList) as? [[String: Any]] {
            // Преобразование массива словарей обратно в массив объектов Result
            favListArray = resultDictArray.compactMap { dict -> Result? in
                return Result(
                    adult: dict["adult"] as? Bool ?? false,
                    backdropPath: dict["backdropPath"] as? String ?? "",
                    genreIDS: dict["genreIDS"] as? [Int] ?? [],
                    id: dict["id"] as? Int ?? 0,
                    originalLanguage: dict["originalLanguage"] as? String ?? "",
                    originalTitle: dict["originalTitle"] as? String ?? "",
                    overview: dict["overview"] as? String ?? "",
                    popularity: dict["popularity"] as? Double ?? 0.0,
                    posterPath: dict["posterPath"] as? String ?? "",
                    releaseDate: dict["releaseDate"] as? String ?? "",
                    title: dict["title"] as? String ?? "",
                    video: dict["video"] as? Bool ?? false,
                    voteAverage: dict["voteAverage"] as? Double ?? 0.0,
                    voteCount: dict["voteCount"] as? Int ?? 0
                )
            }
            print("print getFavList \(favListArray.count)")
            UserDefaults.standard.set(resultDictArray, forKey: Constants.UserDefaults.favouritesList)
            reloadData()
        }
    }

    func removeItemFromFavorites(_ item: Result) {
        if let index = favListArray.firstIndex(where: { $0 == item }) {
            favListArray.remove(at: index)
            // Обновление сохраненных данных в UserDefaults
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
            print("print removeItemFromFavorites \(favListArray.count)")
            UserDefaults.standard.set(resultDictArray, forKey: Constants.UserDefaults.favouritesList)
            reloadData()
        }
    }

}

// MARK: - @objc private extension
@objc private extension FavouritesViewController {

    func cellLongPressed(_ gesture: UILongPressGestureRecognizer) {
        guard let cell = gesture.view as? FavouritesTableViewCell else { return }

        switch gesture.state {
        case .began:
            // Обработка начала долгого нажатия на ячейку
            guard let indexPath = tableView.indexPath(for: cell) else { return }

            let item = favListArray[indexPath.row]
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.prepare()

            removeItemFromFavorites(item)
            feedbackGenerator.impactOccurred()
        default:
            break
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as! FavouritesTableViewCell
        let model = favListArray[indexPath.row]
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed(_:)))
        cell.addGestureRecognizer(longPressGesture)
        cell.configurationCell(model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = self.navigationController else { return }
        let storyboard = UIStoryboard(name: "FavouritesDetail", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FavouritesDetailViewController") as! FavouritesDetailViewController
        controller.movieModel = favListArray
        controller.indexPath = indexPath
        navController.pushViewController(controller, animated: true)
    }

}
