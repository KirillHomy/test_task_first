//
//  Constants.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 16.04.2023.
//

import Foundation

enum Constants {

    static let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=09b1a389fe9a9891ef2596e497a4580f"
    static let prefixPhoto = "https://image.tmdb.org/t/p/w500"

    enum Text {
        static let list = "List"
        static let favourites = "Favourites"
        static let detail = "Detail"
        static let favouritesdetail = "Favourites Detail"
    }

    enum UserDefaults {
        static let favouritesList = "favList"
    }

}
