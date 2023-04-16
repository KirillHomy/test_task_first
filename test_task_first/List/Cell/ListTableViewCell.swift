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
    let imageMovie = UIImageView()
    let label = UILabel()

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
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(model.results[index.row].backdropPath)") {
            let task = URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                guard let data = data else {
                    print("No image data returned")
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.imageMovie.image = image
                }
            }
            task.resume()
        }
        label.text = model.results[index.row].originalTitle
    }

}

// MARK: - Private extension
private extension ListTableViewCell {

    func setupUI() {
        setupImage()
        setupLabel()
        backgroundColor = .clear
    }

    func setupImage() {
        contentView.addSubview(imageMovie)
        imageMovie.contentMode = .scaleAspectFill
        imageMovie.layer.cornerRadius = 10
        imageMovie.clipsToBounds = true

        imageMovie.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(16)
            make.width.height.equalTo(90)
        }
    }

    func setupLabel() {
        contentView.addSubview(label)
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .label
        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageMovie.snp.centerY)
            make.leading.equalTo(imageMovie.snp.trailing).offset(16)
        }
    }

}
