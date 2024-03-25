//
//  PersistenceManager.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

protocol PersistenceManagerInterface {
    func historyStats() -> PersistenceManager.HistoryStatsResult
    
    func historyStats(category: Category) -> PersistenceManager.HistoryStatsResult
    
    func unansweredQuestionsCount() -> Int
    
    func insert(history: History) -> Void
    
    func clearHistory()
}

/// Helper class to interact with a `ModelContext`
final class PersistenceManager: PersistenceManagerInterface {
    var modelContext: ModelContext?
    
    /// Removes all objects from the DB
    func clear() {
        do {
            try modelContext?.delete(model: Category.self)
            try modelContext?.delete(model: Prompt.self)
            try modelContext?.delete(model: Choice.self)
            try modelContext?.delete(model: History.self)
        } catch {
            print("Failed to clear database.")
        }
    }
    
    /// Returns the number of correct answers / total answers & that ratio as a percentage
    /// e.g. 3/4 (75%)
    /// If a category is supplied, include the category's name within the predicate
    func historyStats() -> HistoryStatsResult {
        let total = historyCount(descriptor: HistoryStatsType.none.descriptor)
        let correctCount = historyCount(descriptor: HistoryStatsType.isCorrect(true).descriptor)
        return HistoryStatsResult(resultCount: correctCount, total: total)
    }
    
    /// Returns the number of correct answers / total answers & that ratio as a percentage
    /// e.g. 3/4 (75%)
    /// If a category is supplied, include the category's name within the predicate
    func historyStats(category: Category) -> HistoryStatsResult {
        let total = historyCount(descriptor: HistoryStatsType.category(category).descriptor)
        let correctCount = historyCount(descriptor: HistoryStatsType.isCorrectAndCategory(true, category).descriptor)
        return HistoryStatsResult(resultCount: correctCount, total: total)
    }
    
    /// Returns the number of total number of unanswered questions
    func unansweredQuestionsCount() -> Int {
        let promptsCount = promptsCount(descriptor: FetchDescriptor<Prompt>())
        
        if (promptsCount > 0) {
            let historyCount = historyCount(descriptor: FetchDescriptor<History>())
            return promptsCount - historyCount
        }
        
        return 0
    }
    
    /// Inserts a history object into the model context
    func insert(history: History) -> Void {
        modelContext?.insert(history)
    }
    
    /// Removes all `History` objects from the DB
    func clearHistory() {
        do {
            try modelContext?.delete(model: History.self)
        } catch {
            print("Failed to reset history.")
        }
    }
}

// MARK: - Prompts helpers

extension PersistenceManager {
    /// Returns the prompt count for the descriptor
    private func promptsCount(descriptor: FetchDescriptor<Prompt>) -> Int {
        return (try? modelContext?.fetchCount(descriptor)) ?? 0
    }
}

// MARK: - History helpers

extension PersistenceManager {
    /// Returns the number of questions answered correctly
    /// If a category is supplied, include the category's name within the predicate
    private func correctHistoryCount(category: Category?) -> Int {
        var descriptor = FetchDescriptor<History>(predicate: #Predicate { $0.isCorrect })
        if let category = category {
            let name = category.name
            descriptor = FetchDescriptor<History>(predicate: #Predicate {
                $0.isCorrect && $0.categoryName == name
            })
        }
        
        return historyCount(descriptor: descriptor)
    }
    
    /// Returns the history count for the descriptor
    private func historyCount(descriptor: FetchDescriptor<History>) -> Int {
        return (try? modelContext?.fetchCount(descriptor)) ?? 0
    }
}

struct PersistenceManagerKey: EnvironmentKey {
    static let defaultValue: PersistenceManager = PersistenceManager()
}
