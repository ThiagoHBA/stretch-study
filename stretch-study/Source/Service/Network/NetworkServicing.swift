//
//  NetworkServicing.swift
//  stretch-study
//
//  Created by Thiago Henrique on 17/10/22.
//

import Foundation

protocol NetworkServicing {
    func fetch(endpoint: URLRequest, completion: @escaping (Result<Data, HTTPError>) -> Void)
}
