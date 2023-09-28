//
//  CharacterViewModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 19.08.2023.
//

import Foundation

protocol CharactersViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol CharacterViewModelProtocol: AnyObject {
    init (view: CharactersViewProtocol,
          networkManager: NetworkServiceProtocol,
          router: RouterProtocol
    )
    var characters: [CharacterModel]? { get set }
    func fetchCharacters()
    func tapOnTheCharacter(indexPath: IndexPath)
}

final class CharacterViewModel: CharacterViewModelProtocol {
    weak var view: CharactersViewProtocol?
    var router: RouterProtocol?
    let networkManager: NetworkServiceProtocol
    var characters: [CharacterModel]?

    required init (view: CharactersViewProtocol,
                   networkManager: NetworkServiceProtocol,
                   router: RouterProtocol
    ) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
    }

    func fetchCharacters() {
        if let url = URL(string: Constants.characterApi) {
            networkManager.fetchRequest(modelType: Characters.self, with: url) {
                [weak self] result in
                guard let self else {
                    return
                }

                DispatchQueue.main.async {
                    switch result {
                    case .success(let character):
                        self.characters = character.results
                        self.view?.success()
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        } else {
            print(NetworkError.invalidUrl)
        }
    }

    func tapOnTheCharacter(indexPath: IndexPath) {
        guard let character = characters?[indexPath.item] else {
            return
        }
        router?.showDetail(urlCharacter: character.url)
    }
}
