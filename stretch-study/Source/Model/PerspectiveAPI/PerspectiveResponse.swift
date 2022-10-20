//
//  PerspectiveAPI.swift
//  stretch-study
//
//  Created by Thiago Henrique on 13/10/22.
//
import Foundation

// MARK: - PerspectiveResponse
struct PerspectiveResponse: Codable, Equatable {
    let attributeScores: AttributeScores
    let languages: [String]
    let detectedLanguages: [String]
    
    static func == (lhs: PerspectiveResponse, rhs: PerspectiveResponse) -> Bool {
        return lhs.attributeScores == rhs.attributeScores &&
        lhs.languages == rhs.languages &&
        lhs.detectedLanguages == rhs.detectedLanguages
    }
    
}

// MARK: - AttributeScores
struct AttributeScores: Codable, Equatable {
    static func == (lhs: AttributeScores, rhs: AttributeScores) -> Bool {
        return lhs.toxicity == rhs.toxicity &&
        lhs.threat == rhs.threat &&
        lhs.identityAttack == rhs.identityAttack &&
        lhs.insult == rhs.insult &&
        lhs.profanity == rhs.profanity &&
        lhs.severeToxicity == rhs.severeToxicity
    }
    
    let severeToxicity, identityAttack, profanity, toxicity: AttributeResult
    let threat, insult: AttributeResult
    
    enum CodingKeys: String, CodingKey {
        case severeToxicity = "SEVERE_TOXICITY"
        case identityAttack = "IDENTITY_ATTACK"
        case profanity = "PROFANITY"
        case toxicity = "TOXICITY"
        case threat = "THREAT"
        case insult = "INSULT"
    }
}

// MARK: - IdentityAttack
struct AttributeResult: Codable, Equatable {
    static func == (lhs: AttributeResult, rhs: AttributeResult) -> Bool {
        return lhs.spanScores == rhs.spanScores &&
        lhs.summaryScore == rhs.summaryScore
    }
    
    let spanScores: [SpanScore]
    let summaryScore: Score
}

// MARK: - SpanScore
struct SpanScore: Codable, Equatable {
    static func == (lhs: SpanScore, rhs: SpanScore) -> Bool {
        return lhs.begin == rhs.begin &&
        lhs.end == rhs.end &&
        lhs.score == rhs.score
    }
    
    let begin, end: Int
    let score: Score
}

// MARK: - Score
struct Score: Codable, Equatable {
    let value: Double
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case probability = "PROBABILITY"
}
