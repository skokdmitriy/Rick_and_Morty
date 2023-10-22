//
//  DetailViewModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 20.08.2023.
//

import SwiftUI

protocol DetailViewModelProtocol: AnyObject {
    init (networkService: NetworkServiceProtocol, urlCharacter: URL)
    var episodes: [EpisodeModel] { get set }
    var character: CharacterDetailModel? { get set }
    var isLoading: Bool { get set }
    func fetchCharacterDetail()
}

final class DetailViewModel: DetailViewModelProtocol, ObservableObject {
    @Published var episodes: [EpisodeModel] = []
    @Published var character: CharacterDetailModel?
    @Published var isLoading = true
    private let urlCharacter: URL
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol, urlCharacter: URL) {
        self.networkService = networkService
        self.urlCharacter = urlCharacter
        fetchCharacterDetail()
    }

    func fetchCharacterDetail() {
        let url = urlCharacter
        networkService.fetchRequest(modelType: CharacterDetailModel.self, with: url) { [weak self] result in
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
            networkService.fetchRequest(modelType: EpisodeModel.self, with: url) { [weak self] result in
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
        case Texts.alive:
            return Color(hex: Colors.green)
        case Texts.dead:
            return .red
        case Texts.unknown:
            return .orange
        default:
            return .gray
        }
    }
}
