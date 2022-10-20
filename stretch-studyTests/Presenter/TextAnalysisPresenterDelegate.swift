//
//  TextAnalysisPresenterDelegate.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 18/10/22.
//

import Foundation
@testable import stretch_study

class TextAnalysisPresenterDelegateSpy: TextAnalysisPresenterDelegate {
    enum Message: Equatable, CustomStringConvertible {
        case displayData(TextAnalysisViewEntity)
        case startLoading
        case dismissLoading
        case showError(String, String, ErrorOrigin)
        
        var description: String {
            switch self {
                case let .showError(title, message, origin):
                    return "showError - \(title) - \(message) - \(origin)"
                case .displayData(let entity):
                    return "displayData - \(entity)"
                case .startLoading:
                    return "startLoading"
                case .dismissLoading:
                    return "dismissLoading"
            }
        }
    }
    
    private(set) var receivedMessages: [Message] = []
    
    func startLoading() {
        receivedMessages.append(.startLoading)
    }
    
    func dismissLoading() {
        receivedMessages.append(.dismissLoading)
    }
    
    func displayData(_ entity: TextAnalysisViewEntity) {
        receivedMessages.append(.displayData(entity))
    }
            
    func showError(title: String, message: String, origin: ErrorOrigin) {
        receivedMessages.append(.showError(title, message, origin))
    }
}
