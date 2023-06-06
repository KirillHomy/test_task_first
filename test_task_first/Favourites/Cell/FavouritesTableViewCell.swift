//
//  FavouritesTableViewCell.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 06.06.2023.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {

    // MARK: - Private
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var movieLabel: UILabel!

    // MARK: - Private constants
    private let movieViewModel = MovieViewModel()

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        setupCell()
    }

    // MARK: - Internal Method
    static func nib() -> UINib {
        UINib(nibName: "FavouritesTableViewCell", bundle: nil)
    }

}

// MARK: - External extension
extension FavouritesTableViewCell {

    func configurationCell(_ model: Result) {
        movieViewModel.downloadImage(from: model.backdropPath , to: imageCell)
        movieLabel.text = model.originalTitle
    }

}

// MARK: - private extension
private extension FavouritesTableViewCell {

    func setupCell() {
        contentView.backgroundColor = .clear
    }

}
