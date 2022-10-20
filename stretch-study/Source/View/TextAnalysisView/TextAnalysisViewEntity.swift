//
//  TextAnalysisViewEntity.swift
//  stretch-study
//
//  Created by Thiago Henrique on 18/10/22.
//

import Foundation

struct TextAnalysisViewEntity {
    var perspectiveData: PerspectiveResponse?
    var sentimData: SentimResponse?
    var error: (origin: ErrorOrigin, message: String)?
}

extension TextAnalysisViewEntity: Equatable {
    static func == (lhs: TextAnalysisViewEntity, rhs: TextAnalysisViewEntity) -> Bool {
        return lhs.sentimData == rhs.sentimData && lhs.perspectiveData == rhs.perspectiveData
    }
}
