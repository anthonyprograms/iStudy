//
//  MockPersistenceManager.swift
//  iStudyTests
//
//  Created by Anthony Williams on 3/24/24.
//

import Foundation
@testable import iStudy

final class MockPersistenceManager: PersistenceManagerInterface {
    func historyStats() -> iStudy.PersistenceManager.HistoryStatsResult {
        return iStudy.PersistenceManager.HistoryStatsResult(resultCount: 5, total: 10)
    }
    
    func historyStats(category: iStudy.Category) -> iStudy.PersistenceManager.HistoryStatsResult {
        return iStudy.PersistenceManager.HistoryStatsResult(resultCount: 4, total: 8)
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
