//
//  FileManagerServiceSpy.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 22/10/22.
//

import Foundation
@testable import stretch_study

class FileManagerServiceSpy: FileManagerServicing {
    private(set) var persistedData: [Data] = [Data]()
    
    func writeData(data: Data, on file: String) {
        persistedData.append(data)
    }
    
    func loadData(on file: String) -> Data? {
        return persistedData.first
    }
    
    func complete(with data: Data, at index: Int = 0) {
        self.persistedData[index] = data
    }
}
