//
//  DetailViewModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 20.08.2023.
//

import SwiftUI

protocol DetailViewModelProtocol: AnyObject {
    init (networkManager: NetworkServiceProtocol, router: RouterProtocol, urlCharacter: URL)
    var episodes: [EpisodeModel] { get set }
    var character: CharacterDetailModel? { get set }
    var isLoading: Bool { get set }
    func fetchCharacterDetail()
}

final class DetailViewModel: DetailViewModelProtocol, ObservableObject {

    @Published var episodes: [EpisodeModel] = []
    @Published var character: CharacterDetailModel?
    @Published var isLoading = true
    private let router: RouterProtocol?
    private let networkManager: NetworkServiceProtocol
    private let urlCharacter: URL


    required init(networkManager: NetworkServiceProtocol, router: RouterProtocol, urlCharacter: URL) {
        self.networkManager = networkManager
        self.urlCharacter = urlCharacter
        self.router = router
        fetchCharacterDetail()
    }

    func fetchCharacterDetail() {
        let url = urlCharacter
        networkManager.fetchRequest(modelType: CharacterDetailModel.self, with: url) { [weak self] result in
            guard let self else {
                return
            }

            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    self.character = character
                    self.fetchEpisodes()
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func fetchEpisodes() {
        character?.episode.forEach { url in
            networkManager.fetchRequest(modelType: EpisodeModel.self, with: url) { [weak self] result in
                guard let self else {
                    return
                }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let episodes):
                        self.episodes.append(episodes)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }

    func statusColor(for status: String) -> Color {
        switch status {
        case Constants.alive:
            return Color(Colors.greenText)
        case Constants.dead:
            return .red
        case Constants.unknown:
            return .orange
        default:
            return .gray
        }
    }
}
