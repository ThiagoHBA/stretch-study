//
//  PerspectiveAPI.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//
import Foundation

// MARK: - PerspectiveResponse
struct PerspectiveResponse: Codable {
    let attributeScores: AttributeScores
    let languages, detectedLanguages: [String]
}

// MARK: - AttributeScores
struct AttributeScores: Codable {
    let severeToxicityExperimental, toxicity: SevereToxicityExperimental

    enum CodingKeys: String, CodingKey {
        case severeToxicityExperimental = "SEVERE_TOXICITY_EXPERIMENTAL"
        case toxicity = "TOXICITY"
    }
}

// MARK: - SevereToxicityExperimental

struct SevereToxicityExperimental: Codable {
    let spanScores: [SpanScore]
    let summaryScore: Score
}

// MARK: - SpanScore
struct SpanScore: Codable {
    let begin, end: Int
    let score: Score
}

// MARK: - Score
struct Score: Codable {
    let value: Double
    let type: String
}
