//
//  TextAnalysisPresenter.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

class TextAnalysisPresenter: TextAnalysisPresenting {
    
    private let service: TextAnalysisServicing!
    private var viewEntity = TextAnalysisViewEntity()
    weak var delegate: TextAnalysisPresenterDelegate?
    
    init(service: TextAnalysisServicing) {
        self.service = service
    }
    
    func analyseText(_ text: String) {
        let group = DispatchGroup()
 
        let stretch = Stretch(text: text)
        let perspectiveData = PerspectiveRequest(comment: stretch)
        let sentimData = stretch
        
        delegate?.startLoading()
        analyseToxicity()
        analyseSentiment()
        
        group.notify(queue: DispatchQueue.global()) { [weak self] in
            self?.delegate?.dismissLoading()
            if let requestError = self?.viewEntity.error {
                self?.delegate?.showError(title: "Error", message: requestError)
                return
            }
            if let perspectiveData = self?.viewEntity.perspectiveData, let sentimData = self?.viewEntity.sentimData {
                self?.delegate?.displayData(
                    TextAnalysisViewEntity(
                        perspectiveData: perspectiveData,
                        sentimData: sentimData
                    )
                )
            }
        }
        
        func analyseToxicity() {
            group.enter()
            service.analyseTextToxicity(requestData: perspectiveData) { [weak self] result in
                group.leave()
                switch result {
                    case .success(let response):
                        self?.viewEntity.perspectiveData = response
                    case .failure(let error):
                        self?.viewEntity.error = error.localizedDescription
                }
            }
        }
        func analyseSentiment() {
            group.enter()
            service.analyseTextSentiment(requestData: sentimData) { [weak self] result in
                group.leave()
                switch result {
                    case .success(let response):
                        self?.viewEntity.sentimData = response
                    case .failure(let error):
                        self?.viewEntity.error = error.localizedDescription
                }
            }
        }
    }
}
