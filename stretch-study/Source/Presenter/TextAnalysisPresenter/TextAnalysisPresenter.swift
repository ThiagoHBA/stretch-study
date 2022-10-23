//
//  TextAnalysisPresenter.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

class TextAnalysisPresenter: TextAnalysisPresenting {
    private let service: TextAnalysisServicing!
    private let persistence: DraftServicing!
    private var viewEntity = TextAnalysisViewEntity()
    weak var delegate: TextAnalysisPresenterDelegate?
    
    init(service: TextAnalysisServicing, persistence: DraftServicing) {
        self.service = service
        self.persistence = persistence
    }
    
    func initState() {
        guard let draft: Stretch = persistence.getDraft() else { return }
        delegate?.displayDraft(draft)
    }

    func saveDraft(_ draft: Stretch) {
        persistence.writeDraft(data: draft)
    }
    
    func analyseText(_ text: String, onEnd: @escaping () -> Void ) {
        typealias Error = (origin: ErrorOrigin, message: String)
        
        let group = DispatchGroup()
        let stretch = Stretch(text: text)
        let perspectiveData = PerspectiveRequest(comment: stretch)
        let sentimData = stretch
        var errors: [Error] = []
        
        delegate?.startLoading()
        analyseToxicity()
        analyseSentiment()
        
        group.notify(queue: DispatchQueue.global()) { [weak self] in
            guard let self = self else { return }
            self.delegate?.dismissLoading()
            
            if errors.count >= 2, let requestError = errors.last {
                self.delegate?.showError(title: "Error", message: requestError.message, origin: requestError.origin)
            }
            
            self.delegate?.displayData(self.viewEntity)
            onEnd()
        }
    
        func analyseToxicity() {
            group.enter()
            service.analyseTextToxicity(requestData: perspectiveData) { [weak self] result in
                switch result {
                    case .success(let response):
                        self?.viewEntity.perspectiveData = response
                    case .failure(let error):
                        errors.append((ErrorOrigin.perspective, error.localizedDescription))
                }
                group.leave()
            }
        }
        func analyseSentiment() {
            group.enter()
            service.analyseTextSentiment(requestData: sentimData) { [weak self] result in
                switch result {
                    case .success(let response):
                        self?.viewEntity.sentimData = response
                    case .failure(let error):
                        errors.append((ErrorOrigin.sentim, error.localizedDescription))
                }
                group.leave()
            }
        }
    }
}
