//
//  TextAnalysisPresenter.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

class TextAnalysisPresenter: TextAnalysisPresenting {
    private let service: TextAnalysisServicing!
    
    init(service: TextAnalysisServicing) {
        self.service = service
    }
}
