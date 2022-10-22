//
//  DraftServiceTest.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 21/10/22.
//

import XCTest
@testable import stretch_study

class DraftServiceTest: XCTestCase {
    func test_writeDraft_whenValidData_shouldWriteCorrectly() {
        let (sut, doubles) = makeSUT()
        let (_ , response) = generateResponse()
        sut.writeDraft(data: response)
        XCTAssertTrue(!doubles.persistedData.isEmpty)
    }
    
    func test_loadDraft_whenValidData_shouldReturnValues() {
        let (sut, _) = makeSUT()
        let (_, response) = generateResponse()
        sut.writeDraft(data: response)
        let draft = sut.getDraft()
        XCTAssertNotNil(draft)
        XCTAssertEqual(draft, response)
    }
}

extension DraftServiceTest: Testing {
    typealias SutAndDoubles = (
        sut: DraftService,
        doubles: (
            FileManagerServiceSpy
        )
    )
    
    typealias DataAndResponses = (
        data: String,
        response: (
            Stretch
        )
    )
    
    func makeSUT() -> SutAndDoubles {
        let manager = FileManagerServiceSpy()
        let sut = DraftService(fileManager: manager)
        
        return (sut, (manager))
    }
    
    func generateResponse() -> DataAndResponses {
        let data = ""
        let response = Stretch(text: data)
        return (data, (response))
    }
    
    
}
