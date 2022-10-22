//
//  FileManagerService.swift
//  stretch-study
//
//  Created by Thiago Henrique on 20/10/22.
//

import Foundation

struct FileManagerService: FileManagerServicing {
    let manager: FileManager!
    
    init(manager: FileManager = FileManager.default) {
        self.manager = manager
    }
    
    private var defaultUrl: URL? {
        return manager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func writeData(data: Data, on file: String) {
        if let url = defaultUrl {
            let filePath = url.appendingPathComponent(file)
            do {
                try data.write(to: filePath)
            } catch {
                print(error)
            }
        }
    }
    
    func loadData(on file: String) -> Data? {
        if let url = defaultUrl {
            let filePath = url.appendingPathComponent(file)
            return manager.contents(atPath: filePath.path)
        }
        
        return nil
    }
}
