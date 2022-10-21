//
//  NetworkServicing.swift
//  stretch-study
//
//  Created by Thiago Henrique on 17/10/22.
//

import Foundation

protocol NetworkServicing {
    func fetch(endpoint: EndpointProtocol, completion: @escaping (Result<Data, HTTPError>) -> Void)
}
