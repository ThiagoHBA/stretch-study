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
        
        let endpoint = SentimEndpoint(body: encodedData)
        let loader = EndpointLoader<SentimResponse>()
        
        client.fetch(endpoint: endpoint) { result in loader.load(result: result, completion: completion)}
    }
    
    func analyseTextToxicity(
        requestData: PerspectiveRequest,
        completion: @escaping (Result<PerspectiveResponse, Error>) -> Void
    ) {
        guard let encodedData = try? JSONEncoder().encode(requestData) else {
            completion(.failure(MapperError.encodingError))
            return
        }
        let endpoint = PerspectiveEndPoint(body: encodedData)
        let loader = EndpointLoader<PerspectiveResponse>()
        
        client.fetch(endpoint: endpoint) { result in loader.load(result: result, completion: completion)}
    }
}
