import Foundation

// MARK: - SentimResponse
struct SentimResponse: Codable {
    let result: SentimResult
    let sentences: [Sentence]
}

// MARK: - Result
struct SentimResult: Codable {
    let polarity: Double
    let type: String
}

// MARK: - Sentence
struct Sentence: Codable {
    let sentence: String
    let sentiment: SentimResult
}
