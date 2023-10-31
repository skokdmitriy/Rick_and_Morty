//
//  NetworkService.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 19.08.2023.
//

import Foundation

enum NetworkError: Error {
    case requestError
    case parsingError
}

protocol NetworkServiceProtocol: AnyObject {
    func fetchRequest<T: Decodable>(modelType: T.Type,
                                    with url: URL,
                                    completion: @escaping(Result<T, NetworkError>) -> Void
    )
}

final class NetworkService: NetworkServiceProtocol {
    private let session = URLSession.shared

    func fetchRequest<T: Decodable>(modelType: T.Type,
                                    with url: URL,
                                    completion: @escaping(Result<T, NetworkError>) -> Void
    ) {

        let dataTask = session.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(.requestError))
                return
            }
            
            guard let data else {
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try jsonDecoder.decode(T.self, from: data)
                return completion(.success(result))
            } catch {
                return completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}
