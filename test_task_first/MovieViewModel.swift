//
//  MovieViewModel.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 09.04.2023.
//

import Foundation

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

}
