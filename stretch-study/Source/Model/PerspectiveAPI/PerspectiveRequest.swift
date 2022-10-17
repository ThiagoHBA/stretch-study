//
//  PerspectiveRequest.swift
//  stretch-study
//
//  Created by Thiago Henrique on 15/10/22.
//

import Foundation

// MARK: - PerspectiveRequest
struct PerspectiveRequest: Encodable {
    let comment: Comment
    let requestedAttributes = RequestedAttributes()
}

// MARK: - Comment
struct Comment: Codable {
    let text: String
}

// MARK: - RequestedAttributes
struct RequestedAttributes: Encodable {
    let toxicity = EmptyDict()
    let severeToxicity = EmptyDict()
    let identityAttack = EmptyDict()
    let insult = EmptyDict()
    let profanity = EmptyDict()
    let threat = EmptyDict()

    enum CodingKeys: String, CodingKey {
        case toxicity = "TOXICITY"
        case severeToxicity = "SEVERE_TOXICITY"
        case identityAttack = "IDENTITY_ATTACK"
        case insult = "INSULT"
        case profanity = "PROFANITY"
        case threat = "THREAT"
    }
}

struct EmptyDict: Encodable {}
