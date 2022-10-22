//
//  TextAnalysisServicing.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

protocol TextAnalysisServicing {
    func analyseTextToxicity(requestData: PerspectiveRequest, completion: @escaping (Result<PerspectiveResponse, Error>) -> Void)
    func analyseTextSentiment(requestData: Stretch, completion: @escaping (Result<SentimResponse, Error>) -> Void)
}
