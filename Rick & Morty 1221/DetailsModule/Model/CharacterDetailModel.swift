//
//  CharacterDetailModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import Foundation

struct CharacterDetailModel: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let image: URL
    let episode: [URL]
}

struct Location: Decodable {
    let name: String
}
