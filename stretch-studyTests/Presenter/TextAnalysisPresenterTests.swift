//
//  TextAnalysisPresenterTest.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 18/10/22.
//

import XCTest
@testable import stretch_study

private typealias SutAndDoubles = (
    sut: TextAnalysisPresenter,
    doubles: (
        serviceSpy: TextAnalysisServiceSpy,
        delegateSpy: TextAnalysisPresenterDelegateSpy
    )
)
final class TextAnalysisPresenterTests: XCTestCase {
    
    func test_loadInitialState_whenRequestSuccess_shouldCallDelegateCorrectly() {
        let expectation = XCTestExpectation(description: "End Analysis")
        let (sut, doubles) = makeSUT()
        let text = "Hello, i am a text!"
        let perspectiveData = createPerspectiveResponse(text)
        let sentimData = createSentimResponse(text)
        
        sut.analyseText(text) {
            expectation.fulfill()
            let expectedData = TextAnalysisViewEntity(perspectiveData: perspectiveData, sentimData: sentimData)
            XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.startLoading, .dismissLoading, .displayData(expectedData)])
        }
        
        doubles.serviceSpy.complete(with: Result<PerspectiveResponse, Error>.success(perspectiveData))
        doubles.serviceSpy.complete(with: Result<SentimResponse, Error>.success(sentimData))
        
        wait(for: [expectation], timeout: 5)
    }
    
    private func makeSUT() -> SutAndDoubles {
         let serviceSpy = TextAnalysisServiceSpy()
         let delegateSpy = TextAnalysisPresenterDelegateSpy()
         let sut = TextAnalysisPresenter(service: serviceSpy)
         sut.delegate = delegateSpy
         
         return (sut, (serviceSpy, delegateSpy))
     }
    
    
    private func createPerspectiveResponse(_ text: String) -> PerspectiveResponse {
        return PerspectiveResponse(
            attributeScores: AttributeScores(
                severeToxicity: AttributeResult(spanScores: [SpanScore(begin: 0, end: text.count, score: Score(value: 0.9, type: .probability))], summaryScore: Score(value: 0.9, type: .probability)),
                identityAttack: AttributeResult(spanScores: [SpanScore(begin: 0, end: text.count, score: Score(value: 0.9, type: .probability))], summaryScore: Score(value: 0.9, type: .probability)),
                profanity: AttributeResult(spanScores: [SpanScore(begin: 0, end: text.count, score: Score(value: 0.9, type: .probability))], summaryScore: Score(value: 0.9, type: .probability)),
                toxicity: AttributeResult(spanScores: [SpanScore(begin: 0, end: text.count, score: Score(value: 0.9, type: .probability))], summaryScore: Score(value: 0.9, type: .probability)),
                threat: AttributeResult(spanScores: [SpanScore(begin: 0, end: text.count, score: Score(value: 0.9, type: .probability))], summaryScore: Score(value: 0.9, type: .probability)),
                insult: AttributeResult(spanScores: [SpanScore(begin: 0, end: text.count, score: Score(value: 0.9, type: .probability))], summaryScore: Score(value: 0.9, type: .probability))
            ),
            languages: ["en"],
            detectedLanguages: ["en"]
        )
    }
    private func createSentimResponse(_ text: String) -> SentimResponse {
        SentimResponse(
            result: SentimResult(
                polarity: 0.9, type: "neutral"
            ),
            sentences: [Sentence(sentence: "Hello, i am a text", sentiment: SentimResult(polarity: 0.9, type: "neutral"))]
        )
    }
}
