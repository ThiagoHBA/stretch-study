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
        self.textAnalysisView = TextAnalysisView(frame: UIScreen.main.bounds)
        self.view = self.textAnalysisView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
