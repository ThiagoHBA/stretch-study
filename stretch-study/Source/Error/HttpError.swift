//
//  HttpError.swift
//  stretch-study
//
//  Created by Thiago Henrique on 15/10/22.
//

import Foundation

enum HTTPError: Error, LocalizedError {
    case transportError(Error)
    case serverSideError(Int)
    
    var errorDescription: String? {
        switch self {
            case .transportError:
                return "Error while sending data to server!"
            case .serverSideError(let statusCode):
                return getDescription(of: statusCode)
        }
    }
}

extension HTTPError {
    private func getDescription(of statusCode: Int) -> String {
        if (400...499).contains(statusCode) {
            return "Please make sure you filled in the all the required fields correctly. \(statusCode)"
        } else if (500...599).contains(statusCode) {
            return "Sorry, couldn't reach our server. \(statusCode)"
        } else if (700...).contains(statusCode) {
            return "Sorry, something went wrong. Try again later. \(statusCode)"
        }
        
        return "Unknown"
    }
}
