//
//  Router.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 14.09.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(urlCharacter: URL)
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?
                .createCharacterModule(router: self) else {
                return
            }
            navigationController.setupNavigationController()
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showDetail(urlCharacter: URL) {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createDetailModule(urlCharacter: urlCharacter, router: self) else {
                return
            }
            navigationController.pushViewController(mainViewController, animated: true)
        }
    }
}
