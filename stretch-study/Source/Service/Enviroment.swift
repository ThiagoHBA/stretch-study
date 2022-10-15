//
//  Enviroment.swift
//  stretch-study
//
//  Created by Thiago Henrique on 15/10/22.
//

import Foundation

public enum Enviroment {
    enum Keys {
        static let perspectiveApiKey = "PERSPECTIVE_API_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist not found!")
        }
        return dict
    }()
    
    static let perspectiveApiKey: String = {
        guard let apiKeyString = Enviroment.infoDictionary[Keys.perspectiveApiKey] as? String else {
            fatalError("Key not found on info.plist")
        }
        return apiKeyString
    }()
    
}
