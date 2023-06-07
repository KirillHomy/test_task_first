//
//  FavouritesDetailViewController.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 07.06.2023.
//

import UIKit

class FavouritesDetailViewController: UIViewController {

    // MARK: - Internal variables
    var movieModel: [Result]?
    var indexPath: IndexPath?

    // MARK: - Private constants
    private let movieViewModel = MovieViewModel()

    // MARK: - Private IBOutlet
    @IBOutlet private weak var imageViewMovie: UIImageView!
    @IBOutlet private weak var nameMovie: UILabel!
    @IBOutlet private weak var dataMovie: UILabel!
    @IBOutlet private weak var descriptionMoview: UITextView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

// MARK: - Private extension
private extension FavouritesDetailViewController {

    func setupUI() {
        setupnNvigationController()
        setupImage()
        setupName()
        setupData()
        setupDescription()
    }

    func setupnNvigationController() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.isOpaque = true
        navigationController.navigationBar.prefersLargeTitles = false
        navigationItem.title = Constants.Text.favouritesdetail
        navigationItem.backButtonTitle = ""
    }

    func setupImage() {
        guard let model = movieModel,
              let index = indexPath else { return }
        movieViewModel.downloadImage(from: model[index.row].posterPath , to: imageViewMovie)
    }

    func setupName() {
        guard let model = movieModel,
              let index = indexPath else { return }
        nameMovie.text = model[index.row].originalTitle
    }

    func setupData() {
        guard let model = movieModel,
              let index = indexPath else { return }
        dataMovie.text = "Release: \(model[index.row].releaseDate)"
    }

    func setupDescription() {
        guard let model = movieModel,
              let index = indexPath else { return }
        descriptionMoview.text =  model[index.row].overview
    }

}

