//
//  DraftService.swift
//  stretch-study
//
//  Created by Thiago Henrique on 20/10/22.
//

import Foundation

struct DraftService: DraftServicing {
    let fileManager: FileManagerServicing
    
    init(fileManager: FileManagerServicing = FileManagerService()) {
        self.fileManager = fileManager
    }
    
    func writeDraft(data: Stretch) {
        guard let encodeData = try? JSONEncoder().encode(data) else { return }
        fileManager.writeData(data: encodeData, on: draftFile)
    }
    func getDraft() -> Stretch? {
        guard let rawData = fileManager.loadData(on: draftFile) else { return nil }
        guard let decodedData = try? JSONDecoder().decode(Stretch.self, from: rawData) else { return nil }
        return decodedData
    }
}
