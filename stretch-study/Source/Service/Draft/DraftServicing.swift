//
//  DraftServicing.swift
//  stretch-study
//
//  Created by Thiago Henrique on 20/10/22.
//

import Foundation

protocol DraftServicing {
    var draftFile: String { get }
    
    func writeDraft(data: Stretch)
    func getDraft() -> Stretch?
}

extension DraftServicing {
    var draftFile: String {
        return "draft.json"
    }
}
