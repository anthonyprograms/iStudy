//
//  PersistenceManagerTests.swift
//  iStudyTests
//
//  Created by Anthony Williams on 3/26/24.
//

import XCTest
import SwiftData
@testable import iStudy

class PersistenceManagerTests: XCTestCase {
    private let persistenceManager: PersistenceManager
    private let modelContext: ModelContext
    
    override init() {
        persistenceManager = PersistenceManager()
        modelContext = ModelContext(persistenceManager.sharedModelContainer)
        super.init()
    }
    
    override func tearDown() {
        persistenceManager.clear()
    }
    
//    func testCategories() {
//        let cachedCategories = persistenceManager.categories()
//        XCTAssertEqual(cachedCategories.count, 0)
//        
//        persistenceManager.insert(history: history.first!)
//        let updatedCategories = persistenceManager.categories()
//        
//        XCTAssertEqual(updatedCategories.count, 1)
//    }
//    
//    func testInsertHistory() {
//        let cachedHistory = fetchHistory()
//        XCTAssertEqual(cachedHistory.count, 0)
//        
//        persistenceManager.insert(history: history.first!)
//        
//        let updatedHistory = fetchHistory()
//        XCTAssertEqual(updatedHistory.count, 1)
//    }
//    
//    func testClearHistory() {
//        persistenceManager.insert(history: history.first!)
//        
//        let updatedHistory = fetchHistory()
//        XCTAssertEqual(updatedHistory.count, 1)
//        
//        persistenceManager.clear()
//        
//        XCTAssertEqual(updatedHistory.count, 0)
//    }
}

// MARK: - Helpers

private extension PersistenceManagerTests {
    func fetchHistory() -> [History] {
        let descriptor = FetchDescriptor<History>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
}

// MARK: - Models

private extension PersistenceManagerTests {
    var categoryName: String {
        return "SwiftUI"
    }
    
    var categories: [iStudy.Category] {
        return [
            Category(name: categoryName, prompts: prompts)
        ]
    }
    
    var prompts: [Prompt] {
        let categoryName = categoryName
        let promptId_1 = "P001"
        let promptId_2 = "P002"
        
        return [
            Prompt(
                categoryName: categoryName,
                id: promptId_1,
                question: "What is the primary benefit of using SwiftUI for iOS app development?",
                choices: [
                    Choice(promptId: promptId_1, text: "Improved performance", isCorrect: false),
                    Choice(promptId: promptId_1, text: "Reduced development time", isCorrect: true),
                    Choice(promptId: promptId_1, text: "Better backward compatibility", isCorrect: false),
                    Choice(promptId: promptId_1, text: "Enhanced security", isCorrect: false),
                ],
                explanation: "SwiftUI simplifies the process of building user interfaces by using a declarative syntax and providing built-in tools for common tasks, which can significantly reduce the amount of code needed and speed up development time."),
            Prompt(
                categoryName: categoryName,
                id: promptId_2,
                question: "How can you create a button with SwiftUI?",
                choices: [
                    Choice(promptId: promptId_2, text: "Using UIButton class", isCorrect: false),
                    Choice(promptId: promptId_2, text: "Using UILabel class", isCorrect: false),
                    Choice(promptId: promptId_2, text: "Using Text view with onTapGesture modifier", isCorrect: true),
                    Choice(promptId: promptId_2, text: "Using UIImageView class", isCorrect: false),
                ],
                explanation: "In SwiftUI, you can create a button using a Text view and apply the onTapGesture modifier to detect taps and trigger actions. This approach provides a simple and flexible way to create interactive elements in SwiftUI interfaces.")
        ]
    }
    
    var choice: Choice {
        let prompt = prompts[1]
        let text = prompt.choices[0].text
        let isCorrect = prompt.choices[0].isCorrect
        
        return Choice(
            promptId: prompt.id,
            text: text,
            isCorrect: isCorrect
        )
    }
    
    var history: [History] {
        let prompt = prompts[1]
        let text = prompt.choices[0].text
        let isCorrect = prompt.choices[0].isCorrect
        
        return [
            History(
                categoryName: prompt.categoryName,
                promptId: prompt.id,
                isCorrect: isCorrect,
                selectedAnswer: text
            )
        ]
    }
}
