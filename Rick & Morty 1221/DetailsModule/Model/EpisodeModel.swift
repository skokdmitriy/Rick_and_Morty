//
//  EpisodeModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import Foundation

struct Episodes: Decodable {
    let results: [EpisodeModel]
}

struct EpisodeModel: Decodable, Hashable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
}

