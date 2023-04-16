//
//  ApiManager.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 16.04.2023.
//

import Foundation

class ApiManager {

    static let shared = ApiManager()

    func retrieveMovies(success: @escaping ((MovieModel) -> Void), fail: @escaping (() -> Void)) {
        ServiceManager.shared.callService(Constants.urlString) { (responce: MovieModel) in
            success(responce)
        } fail: {
            fail()
        }

    }
}
