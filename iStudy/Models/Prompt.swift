//
//  Prompt.swift
//  iStudy
//
//  Created by Anthony Williams on 3/24/24.
//

import SwiftData

@Model
final class Prompt: Codable {
    @Relationship(deleteRule: .cascade, inverse: \Category.name)
    var categoryName: String
    
    @Attribute(.unique)
    var id: String
    
    var question: String
    var choices: [Choice]
    var explanation: String
    
    init(categoryName: String, id: String, question: String, choices: [Choice], explanation: String) {
        self.categoryName = categoryName
        self.id = id
        self.question = question
        self.choices = choices
        self.explanation = explanation
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categoryName = try container.decode(String.self, forKey: .categoryName)
        id = try container.decode(String.self, forKey: .id)
        question = try container.decode(String.self, forKey: .question)
        choices = try container.decode([Choice].self, forKey: .choices)
        explanation = try container.decode(String.self, forKey: .explanation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categoryName, forKey: .categoryName)
        try container.encode(id, forKey: .id)
        try container.encode(question, forKey: .question)
        try container.encode(choices, forKey: .choices)
        try container.encode(explanation, forKey: .explanation)
    }

    enum CodingKeys: String, CodingKey {
        case categoryName
        case id
        case question
        case choices
        case explanation
    }
}
