//
//  TextAnalysisPresenterDelegate.swift
//  stretch-study
//
//  Created by Thiago Henrique on 15/10/22.
//

import Foundation

protocol TextAnalysisPresenterDelegate: AnyObject {
    func startLoading()
    func dismissLoading()
    func displayData(_ entity: TextAnalysisViewEntity)
    func showError(title: String, message: String)
}
