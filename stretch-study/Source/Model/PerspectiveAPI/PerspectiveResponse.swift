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
    let languages: [String]
    let detectedLanguages: [String]
}

// MARK: - AttributeScores
struct AttributeScores: Codable {
    let severeToxicity, identityAttack, profanity, toxicity: IdentityAttack
    let threat, insult: IdentityAttack

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
struct IdentityAttack: Codable {
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
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case probability = "PROBABILITY"
}
