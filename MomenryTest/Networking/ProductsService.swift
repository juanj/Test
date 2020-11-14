//
//  ProductsService.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import Foundation

enum ProductsServiceError: Error, LocalizedError {
    case badUrl(String)
    case invalidResponse
    case httpError(code: Int, data: Data?)

    var errorDescription: String? {
        switch self {
        case .badUrl(let urlString):
            return "\(urlString) is not a valid URL"
        case .invalidResponse:
            return "Invalid HTTP response"
        case .httpError(let code, let data):
            if let data = data, let stringRepresentation = String(data: data, encoding: .utf8) {
                return "HTTP Error \(code), Data: \(stringRepresentation)"
            }
            return "HTTP Error \(code)"
        }
    }
}

class ProductsService: ProductsServiceable {
    let baseUrl = "https://marketapp-4e2ef.web.app/"
    private let defaultSession = URLSession(configuration: .default)

    func getProducts(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: baseUrl + "api/enums/images") else {
            completion(.failure(ProductsServiceError.badUrl(baseUrl + "api/enums/images")))
            return
        }
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(ProductsServiceError.invalidResponse))
                }
                return
            }

            guard (200...299).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(ProductsServiceError.httpError(code: response.statusCode, data: data)))
                }
                return
            }
        }

        task.resume()
    }
}
