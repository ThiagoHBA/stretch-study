//
//  ViewController.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import UIKit

class TextAnalysisViewController: UIViewController {
    private var textAnalysisView: TextAnalysisView?
    private let presenter: TextAnalysisPresenting!
    
    init(presenter: TextAnalysisPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cicle
    override func loadView() {
        super.loadView()
        self.textAnalysisView = TextAnalysisView(frame: UIScreen.main.bounds, presenter: presenter)
        self.view = self.textAnalysisView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TextAnalysisViewController: TextAnalysisPresenterDelegate, AlertPresentable {
    func displayDraft(_ draft: Stretch) {
        print("Draft: \(draft.text)")
    }
    
    func displayData(_ entity: TextAnalysisViewEntity) {
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                let summaryVC = SummaryViewController()
                self.navigationController?.pushViewController(summaryVC, animated: true)
                print("DATA: \(String(describing: entity.sentimData?.result)) and \(String(describing: entity.perspectiveData?.attributeScores.toxicity))")
            }
        }
    }
    
    func startLoading() {
        self.textAnalysisView?.analysisHasStarted = true
        self.textAnalysisView?.activityIndicator.startAnimating()
    }
    
    func dismissLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.textAnalysisView?.analysisHasStarted = false
            self?.textAnalysisView?.activityIndicator.stopAnimating()
        }
    }
    
    func showError(title: String, message: String, origin: ErrorOrigin) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: title, message: message)
        }
    }
}
