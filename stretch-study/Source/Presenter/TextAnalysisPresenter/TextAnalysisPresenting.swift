//
//  TextAnalysisPresenting.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

protocol TextAnalysisPresenting {
    func initState()
    func saveDraft(_ draft: Stretch) 
    func analyseText(_ text: String, onEnd: @escaping () -> Void)
}
