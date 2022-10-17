//
//  NetworkServicing.swift
//  stretch-study
//
//  Created by Thiago Henrique on 17/10/22.
//

import Foundation

protocol NetworkServicing {
    func fetch<T: Decodable>(endpoint: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}
