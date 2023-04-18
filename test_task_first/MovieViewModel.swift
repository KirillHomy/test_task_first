//
//  MovieViewModel.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 09.04.2023.
//

import Foundation
import UIKit

class MovieViewModel {

    // MARK: - Private variables
    private var model: MovieModel? = nil

    // MARK: - Intrenal method
    func callService() {
        ApiManager.shared.retrieveMovies { responce in
            self.model = responce
        } fail: {
            print("Error")
        }
    }

    func numberOfRowsInSection() -> Int {
        model?.results.count ?? 0
    }

    func movieModel() -> MovieModel? {
        model
    }

    func downloadImage(from url: String, to imageView: UIImageView) {
        guard let imageURL = URL(string: "\(Constants.prefixPhoto)\(url)") else { return }
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
                imageView.image = image
            }
        }
        task.resume()
    }

}
