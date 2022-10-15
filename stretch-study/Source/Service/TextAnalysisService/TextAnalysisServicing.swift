//
//  TextAnalysisServicing.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

protocol TextAnalysisServicing {
    func analyseTextToxicity(text: String, completion: @escaping (Result<PerspectiveResponse, Error>) -> Void)
    func analyseTextSentiment(text: String, completion: @escaping (Result<SentimResponse, Error>) -> Void)
}
