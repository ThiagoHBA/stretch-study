//
//  ViewCoding.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//

import Foundation

protocol ViewCoding {
    func addViewsInHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
    func buildLayout()
}

extension ViewCoding {
    func setupAditionalConfiguration() {}
    
    func buildLayout() {
        addViewsInHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
}
