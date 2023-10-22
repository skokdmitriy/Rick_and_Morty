//
//  CharactersAssemblerModuleBuilder.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 16.10.2023.
//

import UIKit.UIViewController

final class CharactersAssembly {
   static func createModule() -> UIViewController {
        let networkService = NetworkService()
        let router = Router()
        let viewModel = CharacterViewModel(networkService: networkService, router: router)
        let viewController = CharactersViewController(viewModel: viewModel)
        return viewController
    }
}
