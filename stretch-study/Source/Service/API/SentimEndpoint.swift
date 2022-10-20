//
//  SentimEndpoint.swift
//  stretch-study
//
//  Created by Thiago Henrique on 20/10/22.
//

import Foundation

struct SentimEndpoint: EndpointProtocol {
    var urlBase: String = "https://sentim-api.herokuapp.com"
    var path: String = "/api/v1/"
    var httpMethod: HTTPMethod = .post
    var body: Data?
    
    init(body: Data?) { self.body = body }
}
