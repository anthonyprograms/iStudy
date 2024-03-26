//
//  MockPersistenceManager.swift
//  iStudyTests
//
//  Created by Anthony Williams on 3/24/24.
//

import Foundation
import SwiftData
@testable import iStudy

final class MockPersistenceManager: PersistenceManagerInterface {
    let sharedModelContainer: ModelContainer
    
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
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func historyStats(correctType: iStudy.PersistenceManager.HistoryStatsType, totalType: iStudy.PersistenceManager.HistoryStatsType) -> iStudy.PersistenceManager.HistoryStatsResult {
        iStudy.PersistenceManager.HistoryStatsResult(correct: 5, total: 10)
    }
    
    func questionsCount() -> iStudy.PersistenceManager.QuestionsCount {
        iStudy.PersistenceManager.QuestionsCount(total: 5, answered: 3, left: 2)
    }
    
    func unansweredQuestionsCount() -> Int {
        return 20
    }
    
    var cachedCategories = [iStudy.Category]()
    func categories() -> [iStudy.Category] {
        return cachedCategories
    }
    
    func insert(category: iStudy.Category) {
        
    }
    
    private(set) var insertedHistory: [iStudy.History] = []
    func insert(history: iStudy.History) {
        insertedHistory.append(history)
    }
    
    private(set) var clearHistoryCalled = false
    func clearHistory() {
        clearHistoryCalled = true
    }
}
