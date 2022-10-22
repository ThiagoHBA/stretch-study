//
//  TextAnalysisServiceSpy.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 18/10/22.
//

import Foundation
@testable import stretch_study

final class TextAnalysisServiceSpy: TextAnalysisServicing {
    private(set) var toxicityResult: [(Result<PerspectiveResponse, Error>) -> Void] = []
    private(set) var sentimResult: [(Result<SentimResponse, Error>) -> Void] = []

    func analyseTextToxicity(requestData: PerspectiveRequest, completion: @escaping (Result<PerspectiveResponse, Error>) -> Void) {
        toxicityResult.append(completion)
    }
    
    func analyseTextSentiment(requestData: Stretch, completion: @escaping (Result<SentimResponse, Error>) -> Void) {
        sentimResult.append(completion)
    }
        
    public func complete<T>(with data: T, at index: Int = 0) {
        if let perspectiveData = data as? Result<PerspectiveResponse, Error> {
            self.toxicityResult[index](perspectiveData)
        }
        if let sentimData = data as? Result<SentimResponse, Error> {
            self.sentimResult[index](sentimData)
        }
    }
}
