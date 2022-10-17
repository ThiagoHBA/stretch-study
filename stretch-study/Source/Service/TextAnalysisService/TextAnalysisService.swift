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
     
    func analyseTextSentiment(text: String, completion: @escaping (Result<SentimResponse, Error>) -> Void) { }
    
    func analyseTextToxicity(requestData: PerspectiveRequest, completion: @escaping (Result<PerspectiveResponse, Error>) -> Void) {
        guard let encodedData = try? JSONEncoder().encode(requestData) else { return }
        let endpoint = EndpointFactory.perspective.make(with: encodedData)
        client.fetch(endpoint: endpoint, completion: completion)
    }
}
