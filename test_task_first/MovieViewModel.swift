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

    // MARK: - Internal method
    func callService(completion: @escaping (Bool) -> Void) {
        ApiManager.shared.retrieveMovies { [weak self] response in
            guard let sSelf = self else { return }
            sSelf.model = response
            completion(true)
        } fail: {
            print("Error")
            completion(false)
        }
    }

    func numberOfRowsInSection() -> Int {
        guard let model = model else { return 0 }

        return model.results.count
    }

    func movieModel() -> MovieModel? {
        return model
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
