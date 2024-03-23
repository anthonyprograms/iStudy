//
//  PersistenceManager.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

/// Helper class to interact with a `ModelContext`
final class PersistenceManager {
    var modelContext: ModelContext?
    
    /// Removes all objects from the DB
    public func clear() {
        do {
            try modelContext?.delete(model: Category.self)
            try modelContext?.delete(model: Prompt.self)
            try modelContext?.delete(model: Choice.self)
            try modelContext?.delete(model: History.self)
        } catch {
            print("Failed to clear database.")
        }
    }
    
    /// Removes all `History` objects from the DB
    public func clearHistory() {
        do {
            try modelContext?.delete(model: History.self)
        } catch {
            print("Failed to reset history.")
        }
    }
    
    /// Returns the number of questions answered correctly
    /// If a category is supplied, include the category's name within the predicate
    func correctHistoryCount(category: Category?) -> Int {
        var descriptor = FetchDescriptor<History>(predicate: #Predicate { $0.isCorrect })
        if let category = category {
            let name = category.name
            descriptor = FetchDescriptor<History>(predicate: #Predicate {
                $0.isCorrect && $0.categoryName == name
            })
        }
        
        return (try? modelContext?.fetchCount(descriptor)) ?? 0
    }
    
    /// Returns the number of correct answers / total answers & that ratio as a percentage
    /// e.g. 3/4 (75%)
    /// If a category is supplied, include the category's name within the predicate
    func stats(category: Category?) -> String? {
        var descriptor = FetchDescriptor<History>()
        
        if let category = category {
            let name = category.name
            descriptor = FetchDescriptor<History>(predicate: #Predicate {
                $0.categoryName == name
            })
        }
        
        let totalCount = (try? modelContext?.fetchCount(descriptor)) ?? 0
        
        if totalCount > 0 {
            let correctCount = correctHistoryCount(category: category)
            let percentage = Int((Double(correctCount) / Double(totalCount)) * 100)
            return "\(correctCount)/\(totalCount) (\(percentage)%)"
        }
        
        return nil
    }
}

struct PersistenceManagerKey: EnvironmentKey {
    static let defaultValue: PersistenceManager = PersistenceManager()
}

// TODO: Move this
extension EnvironmentValues {
    var persistenceManager: PersistenceManager {
        get { self[PersistenceManagerKey.self] }
        set { self[PersistenceManagerKey.self] = newValue }
    }
}

extension View {
    func persistenceManager(_ manager: PersistenceManager) -> some View {
        self.environment(\.persistenceManager, manager)
    }
}
