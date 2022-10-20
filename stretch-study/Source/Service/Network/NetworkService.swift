//
//  NetworkService.swift
//  stretch-study
//
//  Created by Thiago Henrique on 17/10/22.
//

import Foundation

final class NetworkService: NetworkServicing {
    func fetch(endpoint: EndpointProtocol, completion: @escaping (Result<Data, HTTPError>) -> Void) {
        guard let url = endpoint.makeURL() else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpMethod = endpoint.httpMethod.rawValue
        request.httpBody = endpoint.body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
