//
//  CharactersAssembly.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 16.10.2023.
//

import UIKit

final class CharactersAssembly {
    static func createModule() -> UIViewController {
        let networkService = NetworkService()
        let router = CharacterRouter()
        let viewModel = CharacterViewModel(networkService: networkService, router: router)
        let viewController = CharactersViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }
}
