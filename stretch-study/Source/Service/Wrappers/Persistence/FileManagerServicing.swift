//
//  FileManagerServicing.swift
//  stretch-study
//
//  Created by Thiago Henrique on 20/10/22.
//

import Foundation

protocol FileManagerServicing {
    func writeData(data: Data, on file: String)
    func loadData(on file: String) -> Data?
}
