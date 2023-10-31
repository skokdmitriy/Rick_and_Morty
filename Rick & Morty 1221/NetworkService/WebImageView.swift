//
//  WebImageView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 19.08.2023.
//

import UIKit.UIImageView
import SwiftUI

final class WebImageView: UIImageView, ObservableObject {
    @Published var imageSui: UIImage = UIImage()

    func set(imageURL: URL) {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: imageURL)) {
            self.image = UIImage(data: cachedResponse.data)
            self.imageSui = UIImage(data: cachedResponse.data) ?? UIImage()
            return
        }

        let dataTask = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, _) in
            DispatchQueue.main.async {
                if let data,
                   let response {
                    self?.image = UIImage(data: data)
                    self?.imageSui = UIImage(data: data) ?? UIImage()
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }

    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
