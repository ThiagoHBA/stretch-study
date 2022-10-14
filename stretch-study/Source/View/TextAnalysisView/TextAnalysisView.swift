//
//  TextAnalysisView.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation
import UIKit

class TextAnalysisView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.tintColor = .red
        label.text = "Hello world!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextAnalysisView: ViewCoding {
    func addViewsInHierarchy() {
        self.addSubview(label)
    }
    
    func setupConstraints() {
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
    }
}
