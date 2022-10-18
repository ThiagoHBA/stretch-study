//
//  URL.swift
//  stretch-study
//
//  Created by Thiago Henrique on 17/10/22.
//

import Foundation

extension URLRequest {
    static func postUrlRequest(url: URL, body: Data) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        return urlRequest
    }
}
