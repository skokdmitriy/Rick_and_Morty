//
//  CharacterModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 19.08.2023.
//

import Foundation

struct Characters: Decodable {
    let results: [CharacterModel]
}

struct CharacterModel: Decodable {
    let name: String
    let image: URL
    let url: URL
}
