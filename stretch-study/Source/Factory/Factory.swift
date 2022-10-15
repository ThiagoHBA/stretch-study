//
//  TextAnalysisFactory.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation
import UIKit

enum Factory {
    case textAnalysisVC
}

extension Factory {
    func make() -> UIViewController {
        switch self {
            case .textAnalysisVC:
                return makeTextAnalysisVC()
        }
    }
}

// MARK: - Implementation

extension Factory {
    private func makeTextAnalysisVC() -> UIViewController {
        let service = TextAnalysisService()
        let presenter = TextAnalysisPresenter(service: service)
        let viewController = TextAnalysisViewController(presenter: presenter)
        
        service.analyseTextToxicity(text: "test") { result in
            switch result {
                case .success(let response):
                    print(response.attributeScores)
                case .failure(let error):
                    print(error)
            }
        }
        
        presenter.delegate = viewController
        return viewController
    }
}
