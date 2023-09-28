//
//  ModuleBuilder.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 20.08.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createCharacterModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(urlCharacter: URL, router: RouterProtocol) -> UIViewController
}

final class AssemblerModuleBuilder: AssemblyBuilderProtocol {
    func createCharacterModule(router: RouterProtocol) -> UIViewController {
        let networkManager = NetworkService()
        let viewController = CharactersViewController()
        let viewModel = CharacterViewModel(
          view: viewController,
          networkManager: networkManager,
          router: router)
        viewController.viewModel = viewModel
        return viewController
    }

    func createDetailModule(urlCharacter: URL, router: RouterProtocol) -> UIViewController {
        let networkManager = NetworkService()
        let viewModel = DetailViewModel(
            networkManager: networkManager,
            router: router,
            urlCharacter: urlCharacter)
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }
}
