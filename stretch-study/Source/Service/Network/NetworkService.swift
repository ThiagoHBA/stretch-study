//
//  NetworkService.swift
//  stretch-study
//
//  Created by Thiago Henrique on 17/10/22.
//

import Foundation

final class NetworkService: NetworkServicing {
    func fetch(endpoint: URLRequest, completion: @escaping (Result<Data, HTTPError>) -> Void) {
        URLSession.shared.dataTask(with: endpoint) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(HTTPError.transportError(error!)))
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completion(.failure(HTTPError.serverSideError(status)))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
