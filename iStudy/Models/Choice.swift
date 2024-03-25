//
//  Choice.swift
//  iStudy
//
//  Created by Anthony Williams on 3/24/24.
//

import SwiftData

@Model
final class Choice: Codable {
    @Relationship(deleteRule: .cascade, inverse: \Prompt.id)
    var promptId: String
    
    var text: String
    var isCorrect: Bool // Is the correct choice from the questions
    
    init(promptId: String, text: String, isCorrect: Bool) {
        self.promptId = promptId
        self.text = text
        self.isCorrect = isCorrect
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        promptId = try container.decode(String.self, forKey: .promptId)
        text = try container.decode(String.self, forKey: .text)
        isCorrect = try container.decode(Bool.self, forKey: .isCorrect)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(promptId, forKey: .promptId)
        try container.encode(text, forKey: .text)
        try container.encode(isCorrect, forKey: .isCorrect)
    }

    enum CodingKeys: String, CodingKey {
        case promptId
        case text
        case isCorrect
    }
}
