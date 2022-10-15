//
//  HttpError.swift
//  stretch-study
//
//  Created by Thiago Henrique on 15/10/22.
//

import Foundation

enum HTTPError: Error {
       case transportError(Error)
       case serverSideError(Int)
}
