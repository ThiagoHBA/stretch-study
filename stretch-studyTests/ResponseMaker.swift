//
//  ResponseFactory.swift
//  stretch-studyTests
//
//  Created by Thiago Henrique on 21/10/22.
//

import Foundation
@testable import stretch_study

struct ResponseMaker {
    static func createPerspectiveResponse(_ text: String) -> PerspectiveResponse {
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
    static func createSentimResponse(_ text: String) -> SentimResponse {
        SentimResponse(
            result: SentimResult(
                polarity: 0.9, type: "neutral"
            ),
            sentences: [Sentence(sentence: "Hello, i am a text", sentiment: SentimResult(polarity: 0.9, type: "neutral"))]
        )
    }
}
