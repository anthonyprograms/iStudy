//
//  History.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftData

@Model
final class History {
    @Relationship(deleteRule: .cascade, inverse: \Category.name)
    let categoryName: String
    
    @Relationship(deleteRule: .cascade, inverse: \Prompt.id)
    let promptId: String
    
    let isCorrect: Bool
    
    let selectedAnswer: String
        
    init(categoryName: String, promptId: String, isCorrect: Bool, selectedAnswer: String) {
        self.categoryName = categoryName
        self.promptId = promptId
        self.isCorrect = isCorrect
        self.selectedAnswer = selectedAnswer
    }
}
