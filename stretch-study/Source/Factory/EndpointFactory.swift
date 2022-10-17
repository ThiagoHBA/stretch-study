//
//  EndpointFactory.swift
//  stretch-study
//
//  Created by Thiago Henrique on 17/10/22.
//

import Foundation

enum EndpointFactory {
    case perspective
    case sentim
}

extension EndpointFactory {
    func make(body: Data = Data()) -> URLRequest {
        switch self {
            case .perspective:
                return makePerspectiveEndpoint(body)
            case .sentim:
                return URLRequest(url: URL(string: "")!)
        }
    }
}

extension EndpointFactory {
    private func makePerspectiveEndpoint(_ body: Data) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "commentanalyzer.googleapis.com"
        components.path = "/v1alpha1/comments:analyze"
        components.queryItems = [URLQueryItem(name: "key", value: Enviroment.perspectiveApiKey)]

        guard let url = components.url else { preconditionFailure( "Invalid URL components: \(components)") }
        
        return URLRequest.postUrlRequest(url: url, body: body)
    }
}
