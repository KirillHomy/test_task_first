//
//  ListTableViewCell.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 09.04.2023.
//

import UIKit
import SnapKit

class ListTableViewCell: UITableViewCell {

    // MARK: - Private UI
    private let imageMovie = UIImageView()
    private let label = UILabel()
    private let movieViewModel = MovieViewModel()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method
    func configurationCell(_ model: MovieModel, _ index: IndexPath) {
        movieViewModel.downloadImage(from: model.results[index.row].backdropPath , to: imageMovie)
        label.text = model.results[index.row].originalTitle
    }

}

// MARK: - Private extension
private extension ListTableViewCell {

    func setupUI() {
        setupCell()
        setupImage()
        setupLabel()
    }

    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    func setupImage() {
        contentView.addSubview(imageMovie)
        imageMovie.contentMode = .scaleAspectFill
        imageMovie.layer.cornerRadius = 10
        imageMovie.clipsToBounds = true

        imageMovie.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(20)
            make.width.height.equalTo(80)
        }
    }

    func setupLabel() {
        contentView.addSubview(label)
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .label
        label.numberOfLines = 2
        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageMovie.snp.centerY)
            make.leading.equalTo(imageMovie.snp.trailing).offset(20)
        }
    }

}
