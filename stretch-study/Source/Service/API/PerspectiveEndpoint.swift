//
//  PerspectiveEndpoint.swift
//  stretch-study
//
//  Created by Thiago Henrique on 20/10/22.
//

import Foundation

struct PerspectiveEndPoint: EndpointProtocol {
    var urlBase: String = "https://commentanalyzer.googleapis.com"
    var path: String = "/v1alpha1/comments:analyze"
    var queries: [URLQueryItem] = [URLQueryItem(name: "key", value: Enviroment.perspectiveApiKey)]
    var httpMethod: HTTPMethod = .post
    var body: Data?
    
    init(body: Data?) { self.body = body }
}
