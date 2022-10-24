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
    static private var defaultPlaceholderText = "Your text here!"
    
    var analysisHasStarted: Bool = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let self = self {
                    self.sendToAnalysisButton.isEnabled = !self.analysisHasStarted
                }
                
            }
        }
    }
    var draft: String = "" {
        didSet {
            if !draft.isEmpty {
                recoverDraftButton.isHidden = false
                changeTextViewValue(text: draft, placeholder: true)
                return
            }
            recoverDraftButton.isHidden = true
            changeTextViewValue(text: TextAnalysisView.defaultPlaceholderText)
        }
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .darkGray
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Stretch Study"
        label.font = UIFont.boldSystemFont(ofSize: 36.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Put here the text you want to analyse."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textViewAnalysis: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 8
        textView.clipsToBounds = false
        textView.layer.shadowOpacity = 0.4
        textView.layer.shadowOffset = CGSize(width: -1, height: 3)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let footNote: UILabel = {
        let label = UILabel()
        label.text = "Only Available in english"
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sendToAnalysisButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Analyse", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tintColor = .white
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(sendTextToAnalysis), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var recoverDraftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recover draft", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(recoverDraft), for: .touchUpInside)
        return button
    }()
    
    init(frame: CGRect, presenter: TextAnalysisPresenting) {
        self.presenter = presenter
        super.init(frame: frame)
        buildLayout()
        presenter.initState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendTextToAnalysis() {
        if let text = textViewAnalysis.text, !text.isEmpty {
            presenter.analyseText(text, onEnd: {})
        }
    }
    
    @objc func recoverDraft() {
        changeTextViewValue(text: draft, placeholder: false)
        recoverDraftButton.isHidden = true
    }
    
    func changeTextViewValue(text: String, placeholder: Bool = false) {
        if placeholder {
            textViewAnalysis.text = text
            textViewAnalysis.textColor = UIColor.lightGray
            sendToAnalysisButton.isEnabled = false
            return
        }
        sendToAnalysisButton.isEnabled = true
        textViewAnalysis.text = text
        textViewAnalysis.textColor = .black
    }
}

extension TextAnalysisView: ViewCoding {
    func setupAditionalConfiguration() {
        self.textViewAnalysis.delegate = self
        self.backgroundColor = .systemBackground
    }
    
    func addViewsInHierarchy() {
        self.addSubview(label)
        self.addSubview(textViewAnalysis)
        self.addSubview(sendToAnalysisButton)
        self.addSubview(textViewLabel)
        self.addSubview(activityIndicator)
        self.addSubview(footNote)
        self.addSubview(recoverDraftButton)
    }
    
    func setupConstraints() {
        let activityIndicatorConstraints = [
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
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
            sendToAnalysisButton.topAnchor.constraint(equalTo: textViewAnalysis.bottomAnchor, constant: 45),
            sendToAnalysisButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sendToAnalysisButton.heightAnchor.constraint(equalToConstant: 46),
            sendToAnalysisButton.widthAnchor.constraint(equalToConstant: 112)
        ]
        
        let textViewLabelConstraint = [
            textViewLabel.bottomAnchor.constraint(equalTo: textViewAnalysis.topAnchor, constant: -14),
            textViewLabel.leadingAnchor.constraint(equalTo: textViewAnalysis.leadingAnchor),
            textViewLabel.trailingAnchor.constraint(equalTo: textViewAnalysis.trailingAnchor)
        ]
        
        let footNoteConstraints = [
            footNote.topAnchor.constraint(equalTo: textViewAnalysis.bottomAnchor, constant: 5),
            footNote.trailingAnchor.constraint(equalTo: textViewAnalysis.trailingAnchor, constant: -10)
        ]
        
        let recoverDraftButtonConstraints = [
            recoverDraftButton.leadingAnchor.constraint(equalTo: textViewAnalysis.leadingAnchor, constant: 8),
            recoverDraftButton.topAnchor.constraint(equalTo: textViewAnalysis.bottomAnchor, constant: 5)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
        NSLayoutConstraint.activate(analysisButtonConstraint)
        NSLayoutConstraint.activate(textViewLabelConstraint)
        NSLayoutConstraint.activate(activityIndicatorConstraints)
        NSLayoutConstraint.activate(footNoteConstraints)
        NSLayoutConstraint.activate(recoverDraftButtonConstraints)
    }
}

extension TextAnalysisView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text, !text.isEmpty {
            presenter.saveDraft(Stretch(text: text))
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            changeTextViewValue(text: "", placeholder: false)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            changeTextViewValue(text: TextAnalysisView.defaultPlaceholderText, placeholder: true)
        }
    }
}
