//
//  SummaryViewController.swift
//  stretch-study
//
//  Created by Thiago Henrique on 23/10/22.
//

import UIKit

class SummaryViewController: UIViewController {
    private var summaryView: SummaryView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.summaryView = SummaryView(frame: UIScreen.main.bounds)
        self.view = self.summaryView
    }
    
    func configure(with model: TextAnalysisViewEntity) {
        print("DATA: \(String(describing: model.sentimData?.result)) and \(String(describing: model.perspectiveData?.attributeScores.toxicity))")
    }
}
