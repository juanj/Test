//
//  CachedImageDownloader.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import UIKit

class CachedImageDownloader: ImageDownloader {
    private let cache = URLCache.shared
    private let defaultSession = URLSession(configuration: .default)

    func downloadImageFromUrl(_ url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            completion(image)
            return
        }

        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            guard let response = response, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            let cachedData = CachedURLResponse(response: response, data: data)
            self.cache.storeCachedResponse(cachedData, for: request)

            DispatchQueue.main.async {
                completion(image)
            }
        }

        task.resume()
    }
}
