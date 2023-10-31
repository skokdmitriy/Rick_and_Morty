//
//  CharacterRouter.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 17.10.2023.
//

import UIKit

protocol CharacterRouterProtocol {
    func showDetail(urlCharacter: URL)
}

final class CharacterRouter: CharacterRouterProtocol {
   weak var viewController: UIViewController?

    func showDetail(urlCharacter: URL) {
        if let viewController = viewController {
            let detailViewController = DetailAssembly.createModule(urlCharacter: urlCharacter)
            viewController.navigationController?.pushViewController(detailViewController,
                                                                    animated: true
            )
        }
    }
}
