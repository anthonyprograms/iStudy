//
//  Category.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import Foundation
import SwiftData

@Model
final class Category {
    @Attribute(.unique)
    var name: String
    
    var prompts: [Prompt]
    
    init(name: String, prompts: [Prompt]) {
        self.name = name
        self.prompts = prompts
    }
}

@Model
final class Prompt {
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
}

@Model
final class Choice {
    @Relationship(deleteRule: .cascade, inverse: \Prompt.id)
    var promptId: String
    
    var text: String
    var isCorrect: Bool // Is the correct choice from the questions
    
    init(promptId: String, text: String, isCorrect: Bool) {
        self.promptId = promptId
        self.text = text
        self.isCorrect = isCorrect
    }
}
