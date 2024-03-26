//
//  PersistenceManager.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

protocol PersistenceManagerInterface {
    var sharedModelContainer: ModelContainer { get }
    
    func categories() -> [Category]
    
    func insert(category: Category) -> Void
    
    func insert(history: History) -> Void
    
    func clearHistory()
    
    func historyStats(
        correctType: PersistenceManager.HistoryStatsType,
        totalType: PersistenceManager.HistoryStatsType
    ) -> PersistenceManager.HistoryStatsResult
    
    func questionsCount() -> PersistenceManager.QuestionsCount
}

/// Helper class to interact with a `ModelContext`
final class PersistenceManager: PersistenceManagerInterface {
    let sharedModelContainer: ModelContainer
    private let modelContext: ModelContext
    
    init() {
        let schema = Schema([
            Category.self,
            Prompt.self,
            Choice.self,
            History.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            modelContext = ModelContext(sharedModelContainer)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    /// Removes all objects from the DB
    func clear() {
        do {
            try modelContext.delete(model: Category.self)
            try modelContext.delete(model: Prompt.self)
            try modelContext.delete(model: Choice.self)
            try modelContext.delete(model: History.self)
        } catch {
            print("Failed to clear database.")
        }
    }
    
    // MARK: - Category
    
    /// Returns all`Category` rows that exist
    func categories() -> [Category] {
        let descriptor = FetchDescriptor<Category>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    /// Inserts a `Category` object into the model context
    func insert(category: Category) -> Void {
        modelContext.insert(category)
    }
    
    // MARK: - History
    
    /// Inserts a `History` object into the model context
    func insert(history: History) -> Void {
        modelContext.insert(history)
    }
    
    /// Removes all `History` objects from the DB
    func clearHistory() {
        do {
            try modelContext.delete(model: History.self)
        } catch {
            print("Failed to reset history.")
        }
    }
    
    // MARK: - Question Count
    
    /// Returns the number of total number of unanswered questions
    func questionsCount() -> QuestionsCount {
        let total = promptsCount(descriptor: FetchDescriptor<Prompt>())
        
        var answered: Int = 0
        var left: Int = 0
        
        if (total > 0) {
            answered = historyCount(descriptor: FetchDescriptor<History>())
            left = total - answered
        }
        
        return QuestionsCount(total: total, answered: answered, left: left)
    }
    
    // MARK: - History Stats
    
    /// Returns the number of correct answers / total answers & that ratio as a percentage
    /// e.g. 3/4 (75%)
    /// If a category is supplied, include the category's name within the predicate
    func historyStats(correctType: HistoryStatsType, totalType: HistoryStatsType) -> HistoryStatsResult {
        let total = historyCount(descriptor: totalType.descriptor)
        let correctCount = historyCount(descriptor: correctType.descriptor)
        return HistoryStatsResult(correct: correctCount, total: total)
    }
}

// MARK: - Prompts helpers

extension PersistenceManager {
    /// Returns the prompt count for the descriptor
    private func promptsCount(descriptor: FetchDescriptor<Prompt>) -> Int {
        return (try? modelContext.fetchCount(descriptor)) ?? 0
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
        return (try? modelContext.fetchCount(descriptor)) ?? 0
    }
}

struct PersistenceManagerKey: EnvironmentKey {
    static let defaultValue: PersistenceManager = PersistenceManager()
}
