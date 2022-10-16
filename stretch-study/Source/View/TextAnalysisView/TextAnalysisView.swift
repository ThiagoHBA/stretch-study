//
//  TextAnalysisView.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation
import UIKit

class TextAnalysisView: UIView {
    private let presenter: TextAnalysisPresenting!
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Stretch Study"
        label.font = UIFont.boldSystemFont(ofSize: 36.0)
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Put here the text you want to analyse."
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textViewAnalysis: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var sendToAnalysisButton: UIButton = {
        let button = UIButton()
        button.setTitle("Analyse", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(sendTextToAnalysis), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(frame: CGRect, presenter: TextAnalysisPresenting) {
        self.presenter = presenter
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendTextToAnalysis() {
        if let text = textViewAnalysis.text, !text.isEmpty {
            presenter.analyseText(text)
        }
    }
}

extension TextAnalysisView: ViewCoding {
    
    func addViewsInHierarchy() {
        self.addSubview(label)
        self.addSubview(textViewAnalysis)
        self.addSubview(sendToAnalysisButton)
        self.addSubview(textViewLabel)
    }
    
    func setupConstraints() {
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        let textViewConstraints = [
            textViewAnalysis.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textViewAnalysis.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textViewAnalysis.heightAnchor.constraint(equalToConstant: 160),
            textViewAnalysis.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textViewAnalysis.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        let analysisButtonConstraint = [
            sendToAnalysisButton.topAnchor.constraint(equalTo: textViewAnalysis.bottomAnchor, constant: 26),
            sendToAnalysisButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sendToAnalysisButton.heightAnchor.constraint(equalToConstant: 46),
            sendToAnalysisButton.widthAnchor.constraint(equalToConstant: 112)
        ]
        
        let textViewLabelConstraint = [
            textViewLabel.bottomAnchor.constraint(equalTo: textViewAnalysis.topAnchor, constant: -14),
            textViewLabel.leadingAnchor.constraint(equalTo: textViewAnalysis.leadingAnchor),
            textViewLabel.trailingAnchor.constraint(equalTo: textViewAnalysis.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
        NSLayoutConstraint.activate(analysisButtonConstraint)
        NSLayoutConstraint.activate(textViewLabelConstraint)
    }
}
