//
//  MovieService.swift
//  test_task_first
//
//  Created by Kirill Khomytsevych on 16.04.2023.
//

import Foundation

class ServiceManager {

    static let shared = ServiceManager()

    func callService<T: Decodable>(_ urlString: String, success: @escaping ((T) -> Void), fail: @escaping (() -> Void)) {
        guard let url = URL(string: urlString) else { return }

        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }

            let decode = JSONDecoder()
            do {
                let json = try decode.decode(T.self, from: data)
                success(json)
            } catch {
                fail()
            }
        }
        task.resume()
    }

}
