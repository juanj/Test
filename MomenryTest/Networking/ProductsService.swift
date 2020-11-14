//
//  ProductsService.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import Foundation

enum ProductsServiceError: Error, LocalizedError, CustomStringConvertible {
    case badUrl(String)
    case invalidResponse
    case httpError(code: Int, data: Data?)
    case noData

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
        case .noData:
            return "No data"
        }
    }

    var description: String {
        return errorDescription ?? "Error"
    }
}

class ProductsService: ProductsServiceable {
    let baseUrl = "https://marketapp-4e2ef.web.app/"
    private let defaultSession = URLSession(configuration: .default)

    func getProducts(completion: @escaping (Result<ServerResponse<[Product]>, Error>) -> Void) {
        guard let url = URL(string: baseUrl + "api/enums/imagenes") else {
            completion(.failure(ProductsServiceError.badUrl(baseUrl + "api/enums/imagenes")))
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

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ProductsServiceError.noData))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ServerResponse<[Product]>.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
