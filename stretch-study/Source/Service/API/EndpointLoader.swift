//
//  EndpointLoader.swift
//  stretch-study
//
//  Created by Thiago Henrique on 20/10/22.
//

import Foundation

struct EndpointLoader<T: Decodable> {
    func loadData(from result: Result<Data, HTTPError>, on completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
            case .success(let data):
                do {
                    let decodedJson = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedJson))
                } catch {
                    completion(.failure(MapperError.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
        }
    }
}
