//
//  GameViewModel.swift
//  iStudy
//
//  Created by Anthony Williams on 3/24/24.
//

import SwiftUI

class GameViewModel: ObservableObject {
    var persistenceManager: PersistenceManagerInterface?
    
    var history: [History] = []
    var categories: [Category] = []
    
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var isGameOver: Bool = false
    @Published private(set) var prompt: Prompt?
    @Published var selection: Choice?
    
    private var dataFetched = false
    
    var isChoiceSubmitted: Bool {
        selection != nil
    }
    
    var unansweredQuestions: Int {
        persistenceManager?.unansweredQuestionsCount() ?? 0
    }
    
    /// Fetches categories from the DB
    /// if empty, fetches from the network
    func fetchData() async {
        guard !dataFetched else { return }
        dataFetched = true
        
        let cachedCategories = persistenceManager?.categories() ?? []
        
        // If there are no categories in the cache, fetch them from the network
        if cachedCategories.count == 0, let categories = try? await NetworkManager.fetchData() {
            DispatchQueue.main.async { [weak self] in
                for category in categories {
                    self?.persistenceManager?.insert(category: category)
                }
                self?.categories = categories
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.categories = cachedCategories
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            self?.next()
        }
    }
    
    func next() -> Void {        
        let historyPromptIds = Set(history.map { $0.promptId })
        let availablePrompts = categories.compactMap { $0.prompts }.flatMap { $0 }.filter {
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
}
