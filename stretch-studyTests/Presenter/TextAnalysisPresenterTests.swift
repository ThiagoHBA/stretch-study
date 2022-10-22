//
//  TextAnalysisPresenterTest.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 18/10/22.
//

import XCTest
@testable import stretch_study

final class TextAnalysisPresenterTests: XCTestCase {
    func test_initState_whenFileManagerReturnData_shouldCallDelegate() {
        let (sut, doubles) = makeSUT()
        let (text, _ ) = generateResponse()
        let expectedData = Stretch(text: text)
        doubles.draftSpy.writeDraft(data: expectedData)
        sut.initState()
        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.displayDraft(expectedData)])
    }
    
    func test_saveDraft_whenCalled_shouldSaveDataCorrectly() {
        let (sut, doubles) = makeSUT()
        let (text, _ ) = generateResponse()
        let dataToSave = Stretch(text: text)
        sut.saveDraft(dataToSave)
        XCTAssertEqual(dataToSave, doubles.draftSpy.getDraft())
    }
    
    func test_analyseText_whenRequestSuccess_shouldCallDelegateCorrectly() {
        let expectation = XCTestExpectation(description: "End Analysis")
        let (sut, doubles) = makeSUT()
        let (text, response) = generateResponse()
        
        sut.analyseText(text) {
            let expectedData = TextAnalysisViewEntity(perspectiveData: response.perpectiveResponse, sentimData: response.sentimResponse)
            XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.startLoading, .dismissLoading, .displayData(expectedData)])
            expectation.fulfill()
        }
        
        doubles.serviceSpy.complete(with: Result<PerspectiveResponse, Error>.success(response.perpectiveResponse))
        doubles.serviceSpy.complete(with: Result<SentimResponse, Error>.success(response.sentimResponse))
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_analyseText_whenPerspectiveRequestFails_shouldCallDelegateCorrectly() {
        let expectation = XCTestExpectation(description: "End Analysis")
        let (sut, doubles) = makeSUT()
        let (text, response) = generateResponse()
        let perspectiveError = HTTPError.serverSideError(500)
        
        sut.analyseText(text) {
            let expectedEntity = TextAnalysisViewEntity(perspectiveData: nil, sentimData: response.sentimResponse)
            let expectedError = ("Error", "Sorry, couldn't reach our server. 500", ErrorOrigin.perspective)
            XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.startLoading, .dismissLoading, .showError(expectedError.0, expectedError.1, expectedError.2), .displayData(expectedEntity)])
            expectation.fulfill()
        }
        
        doubles.serviceSpy.complete(with: Result<PerspectiveResponse, Error>.failure(perspectiveError))
        doubles.serviceSpy.complete(with: Result<SentimResponse, Error>.success(response.sentimResponse))
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_analyseText_whenSentimRequestFails_shouldCallDelegateCorrectly() {
        let expectation = XCTestExpectation(description: "End Analysis")
        let (sut, doubles) = makeSUT()
        let (text, response) = generateResponse()
        let sentimError = HTTPError.serverSideError(400)
        
        sut.analyseText(text) {
            let expectedEntity = TextAnalysisViewEntity(perspectiveData: response.perpectiveResponse, sentimData: nil)
            let expectedError = ("Error", "Please make sure you filled in the all the required fields correctly. 400", ErrorOrigin.sentim)
            XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.startLoading, .dismissLoading, .showError(expectedError.0, expectedError.1, expectedError.2), .displayData(expectedEntity)])
            expectation.fulfill()
        }
        
        doubles.serviceSpy.complete(with: Result<PerspectiveResponse, Error>.success(response.perpectiveResponse))
        doubles.serviceSpy.complete(with: Result<SentimResponse, Error>.failure(sentimError))
        
        wait(for: [expectation], timeout: 5)
    }
    
}

extension TextAnalysisPresenterTests: Testing {
    typealias SutAndDoubles = (
        sut: TextAnalysisPresenter,
        doubles: (
            serviceSpy: TextAnalysisServiceSpy,
            delegateSpy: TextAnalysisPresenterDelegateSpy,
            draftSpy: DraftServiceSpy
        )
    )

    typealias DataAndResponses = (
        data: String,
        response: (
            perpectiveResponse: PerspectiveResponse,
            sentimResponse: SentimResponse
        )
    )
    
    func makeSUT() -> SutAndDoubles {
        let serviceSpy = TextAnalysisServiceSpy()
        let delegateSpy = TextAnalysisPresenterDelegateSpy()
        let draftSpy = DraftServiceSpy()
        let sut = TextAnalysisPresenter(service: serviceSpy, persistence: draftSpy)
        sut.delegate = delegateSpy
        return (sut, (serviceSpy, delegateSpy, draftSpy))
    }

    func generateResponse() -> DataAndResponses {
        let text = ""
        let perspectiveData = ResponseMaker.createPerspectiveResponse(text)
        let sentimData = ResponseMaker.createSentimResponse(text)
        return (text, (perspectiveData, sentimData))
    }
}
