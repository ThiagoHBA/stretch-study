//
//  TextAnalysisPresenter.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

class TextAnalysisPresenter: TextAnalysisPresenting {
    
    private let service: TextAnalysisServicing!
    weak var delegate: TextAnalysisPresenterDelegate?
    
    init(service: TextAnalysisServicing) {
        self.service = service
    }
    
    func analyseText(_ text: String) {
        let dataToRequest = PerspectiveRequest(comment: Comment(text: text))
        delegate?.startLoading()
        service.analyseTextToxicity(requestData: dataToRequest) { [weak self] result in
            self?.delegate?.dismissLoading()
            switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    self?.delegate?.showError(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
