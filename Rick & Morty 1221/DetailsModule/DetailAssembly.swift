//
//  DetailAssembly.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 16.10.2023.
//

import UIKit

final class DetailAssembly {
    static func createModule(urlCharacter: URL) -> UIViewController {
        let networkService = NetworkService()
        let viewModel = DetailViewModel(networkService: networkService, urlCharacter: urlCharacter)
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }
}
