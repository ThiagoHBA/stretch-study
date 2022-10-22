//
//  Testing.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 22/10/22.
//

import Foundation

protocol Testing {
    associatedtype SutAndDoubles
    associatedtype DataAndResponses
    func makeSUT() -> SutAndDoubles
    func generateResponse() -> DataAndResponses
}
