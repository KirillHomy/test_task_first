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

            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(T.self, from: data)
                success(json)
            } catch let decodingError as DecodingError {
                // Обработка ошибки декодирования
                switch decodingError {
                case .dataCorrupted(let context):
                    // Обработка недопустимого значения
                    print("Invalid value encountered:", context.debugDescription)
                default:
                    // Другие ошибки декодирования
                    fail()
                }
            } catch {
                // Другие ошибки
                fail()
                print("Error description", error)
            }
        }
        task.resume()
    }

}
