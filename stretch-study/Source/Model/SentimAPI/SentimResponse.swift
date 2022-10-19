import Foundation

// MARK: - SentimResponse
struct SentimResponse: Codable, Equatable {
    static func == (lhs: SentimResponse, rhs: SentimResponse) -> Bool {
        return lhs.result == rhs.result &&
        lhs.sentences == rhs.sentences
    }
    
    let result: SentimResult
    let sentences: [Sentence]
}

// MARK: - Result
struct SentimResult: Codable, Equatable {
    let polarity: Double
    let type: String
}

// MARK: - Sentence
struct Sentence: Codable, Equatable {
    let sentence: String
    let sentiment: SentimResult
}
