//
//  NetworkService.swift
//  stretch-study
//
//  Created by Thiago Henrique on 17/10/22.
//

import Foundation

final class NetworkService: NetworkServicing {
    func fetch<T: Decodable>(endpoint: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
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
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
