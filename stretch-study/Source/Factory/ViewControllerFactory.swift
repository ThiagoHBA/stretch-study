//
//  TextAnalysisFactory.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation
import UIKit

enum ViewControllerFactory {
    case textAnalysisVC
}

extension ViewControllerFactory {
    func make() -> UIViewController {
        switch self {
            case .textAnalysisVC:
                return makeTextAnalysisVC()
        }
    }
}

// MARK: - Implementation

extension ViewControllerFactory {
    private func makeTextAnalysisVC() -> UIViewController {
        let service = TextAnalysisService()
        let presenter = TextAnalysisPresenter(service: service)
        let viewController = TextAnalysisViewController(presenter: presenter)
        
        presenter.delegate = viewController
        return viewController
    }
}
