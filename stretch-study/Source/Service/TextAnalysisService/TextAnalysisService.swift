//
//  TextAnalysisService.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

class TextAnalysisService: TextAnalysisServicing {
    private let client: NetworkService!
    
    init(client: NetworkService = NetworkService()) {
        self.client = client
    }
     
    func analyseTextSentiment(
        requestData: Stretch,
        completion: @escaping (Result<SentimResponse, Error>) -> Void
    ) {
        guard let encodedData = try? JSONEncoder().encode(requestData) else {
            completion(.failure(MapperError.encodingError))
            return
        }
        let endpoint = EndpointFactory.sentim.make(with: encodedData)
        
        client.fetch(endpoint: endpoint) { result in
            switch result {
                case .success(let data):
                    do {
                        let decodedJson = try JSONDecoder().decode(SentimResponse.self, from: data)
                        completion(.success(decodedJson))
                    } catch {
                        completion(.failure(MapperError.decodingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func analyseTextToxicity(
        requestData: PerspectiveRequest,
        completion: @escaping (Result<PerspectiveResponse, Error>) -> Void
    ) {
        guard let encodedData = try? JSONEncoder().encode(requestData) else {
            completion(.failure(MapperError.encodingError))
            return
        }
        let endpoint = EndpointFactory.perspective.make(with: encodedData)
        
        client.fetch(endpoint: endpoint) { result in
            switch result {
                case .success(let data):
                    do {
                        let decodedJson = try JSONDecoder().decode(PerspectiveResponse.self, from: data)
                        completion(.success(decodedJson))
                    } catch {
                        completion(.failure(MapperError.decodingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
}
