//
//  TextAnalysisService.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

class TextAnalysisService: TextAnalysisServicing {
    func analyseTextSentiment(text: String, completion: @escaping (Result<SentimResponse, Error>) -> Void) {
        
    }
    
    func analyseTextToxicity(text: String, completion: @escaping (Result<PerspectiveResponse, Error>) -> Void) {
        guard let url = URL(
            string: "\(Constants.PerspectiveApiBaseURL)key=\(Enviroment.perspectiveApiKey)"
        ) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody =
        """
            {
                \"comment\": {
                    \"text\": \"Hello! i`m a text! Your idiot!\"
                },
                \"requestedAttributes\": {
                    \"TOXICITY\": {},
                    \"SEVERE_TOXICITY\": {},
                    \"IDENTITY_ATTACK\": {},
                    \"INSULT\": {},
                    \"PROFANITY\": {},
                    \"THREAT\": {}
                }
            }
        """.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
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
                let perspectiveResult = try JSONDecoder().decode(PerspectiveResponse.self, from: data)
                completion(.success(perspectiveResult))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
