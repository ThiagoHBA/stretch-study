//
//  DraftServiceSpy.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 21/10/22.
//

import Foundation
@testable import stretch_study

class DraftServiceSpy: DraftServicing {
    private(set) var persistedData: Stretch? = nil
    
    func writeDraft(data: Stretch) {
        self.persistedData = data
    }
    
    func getDraft() -> Stretch? {
        return persistedData
    }
    
    deinit { persistedData = nil }
}
