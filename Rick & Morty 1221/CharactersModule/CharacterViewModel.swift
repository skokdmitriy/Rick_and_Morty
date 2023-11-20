//
//  CharacterViewModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 19.08.2023.
//

import UIKit

protocol CharactersViewDelegate: AnyObject {
    func success()
    func failure(error: NetworkError)
}

protocol CharacterViewModelProtocol: AnyObject {
    var characters: [CharacterModel] { get set }
    func fetchCharacters()
    func tapOnTheCharacter(indexPath: IndexPath)
}

final class CharacterViewModel: CharacterViewModelProtocol {
    // MARK: - Properties

    weak var delegate: CharactersViewDelegate?
    var characters: [CharacterModel] = []

    // MARK: - Private properties

    private let router: CharacterRouter
    private let networkService: NetworkServiceProtocol

    // MARK: - Initialization

    init (networkService: NetworkServiceProtocol, router: CharacterRouter) {
        self.router = router
        self.networkService = networkService
    }

    // MARK: - Functions

    func fetchCharacters() {
        if let url = URL(string: Constants.characterApi) {
            networkService.fetchRequest(modelType: Characters.self, with: url) {
                [weak self] result in
                guard let self else {
                    return
                }

                DispatchQueue.main.async {
                    switch result {
                    case .success(let character):
                        self.characters = character.results
                        self.delegate?.success()
                    case .failure(let error):
                        self.delegate?.failure(error: error)
                    }
                }
            }
        } else {
            print(NetworkError.invalidUrl)
        }
    }

    func tapOnTheCharacter(indexPath: IndexPath) {
        let character = characters[indexPath.item]
        router.showDetail(urlCharacter: character.url)
    }
}
