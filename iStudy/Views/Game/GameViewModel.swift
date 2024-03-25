//
//  GameViewModel.swift
//  iStudy
//
//  Created by Anthony Williams on 3/24/24.
//

import SwiftUI

class GameViewModel: ObservableObject {
    var persistenceManager: PersistenceManagerInterface?
     
    var prompts: [Prompt] = []
    var history: [History] = [] {
        didSet { toggleRefresh() }
    }
    
    @Published var prompt: Prompt?
    @Published var selection: Choice?
    @Published var isGameOver: Bool = false
    @Published var refreshToggle: Bool = false
    
    var isChoiceSubmitted: Bool {
        selection != nil
    }
    
    var unansweredQuestions: Int {
        persistenceManager?.unansweredQuestionsCount() ?? 0
    }
    
    func next() -> Void {
        let historyPromptIds = Set(history.map { $0.promptId })
        let availablePrompts = prompts.filter {
            !historyPromptIds.contains($0.id)
        }
        
        guard availablePrompts.count > 0 else {
            isGameOver = true
            return
        }
        
        selection = nil
        
        let index = Int.random(in: 0...availablePrompts.count - 1)
        prompt = availablePrompts[index]
    }
    
    func choiceSelected(_ choiceSelection: Choice) -> Void {
        guard let prompt = prompt else { return }

        let isCorrect = choiceSelection.isCorrect
        
        let history = History(categoryName: prompt.categoryName,
                              promptId: prompt.id,
                              isCorrect: isCorrect,
                              selectedAnswer: choiceSelection.text)
        persistenceManager?.insert(history: history)
    }
    
    func startOver() -> Void {
        persistenceManager?.clearHistory()
        next()
        
        selection = nil
        isGameOver = false
        
    }
    
    /// A workaround to get the view to refresh the `statsText` after
    /// a History object is inserted into the context
    private func toggleRefresh() -> Void {
        refreshToggle = !refreshToggle
    }
}
