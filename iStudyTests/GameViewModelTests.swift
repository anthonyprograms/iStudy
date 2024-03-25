//
//  GameViewModelTests.swift
//  iStudyTests
//
//  Created by Anthony Williams on 3/24/24.
//

import XCTest
@testable import iStudy

/// Switch to iStudyTests scheme to run
class GameViewModelTests: XCTestCase {
    private let mockPersistenceManager = MockPersistenceManager()
    private var viewModel: GameViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = GameViewModel()
        viewModel.persistenceManager = mockPersistenceManager
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testIsChoiceSubmitted() {
        XCTAssertFalse(viewModel.isChoiceSubmitted)
        
        viewModel.selection = Choice(promptId: "P001", text: "Choice", isCorrect: true)
        
        XCTAssertTrue(viewModel.isChoiceSubmitted)
    }
    
    func testUnansweredQuestions() {
        XCTAssertEqual(viewModel.unansweredQuestions, 20)
    }
    
    func testNext_GameOver() {
        XCTAssertFalse(viewModel.isGameOver)
        
        mockPersistenceManager.cachedCategories = []
        viewModel.history = history
        
        viewModel.next()
        
        XCTAssertTrue(viewModel.isGameOver)
    }
    
    // TODO: Fix these tests
    
//    func testNext() {
//        XCTAssertFalse(viewModel.isGameOver)
//        
//        viewModel.history = history
//        viewModel.selection = choice
//        viewModel.categories = categories
//        
//        XCTAssertFalse(viewModel.isGameOver)
//        XCTAssertNotNil(viewModel.selection)
//        XCTAssertNil(viewModel.prompt)
//        
//        viewModel.next()
//        
//        XCTAssertFalse(viewModel.isGameOver)
//        XCTAssertNil(viewModel.selection)
//        XCTAssertNotNil(viewModel.prompt)
//    }
    
//    func testChoiceSelected() {
//        let prompt = categories[0].prompts[0]
//        mockPersistenceManager.cachedCategories = categories
//        viewModel.next()
//        
//        XCTAssertEqual(mockPersistenceManager.insertedHistory.count, 0)
//        
//        viewModel.choiceSelected(choice)
//        
//        let expectedHistory = History(categoryName: prompt.categoryName,
//                                      promptId: prompt.id,
//                                      isCorrect: choice.isCorrect,
//                                      selectedAnswer: choice.text)
//        
//        XCTAssertEqual(mockPersistenceManager.insertedHistory.count, 1)
//
//        guard let insertedHistory = mockPersistenceManager.insertedHistory.first else {
//            XCTFail("No history found for choice selected")
//            return
//        }
//        
//        assertEqualHistory(insertedHistory, expectedHistory)
//    }
}

// MARK: - Helpers

private extension GameViewModelTests {
    func assertEqualHistory(_ first: History, _ second: History) -> Void {
        XCTAssertEqual(first.promptId, second.promptId)
        XCTAssertEqual(first.isCorrect, second.isCorrect)
        XCTAssertEqual(first.categoryName, second.categoryName)
        XCTAssertEqual(first.selectedAnswer, second.selectedAnswer)
    }
}

// MARK: - Models

private extension GameViewModelTests {
    var categories: [iStudy.Category] {
        return [
            Category(name: "SwiftUI", prompts: prompts)
        ]
    }
    
    var prompts: [Prompt] {
        return [
            Prompt(categoryName: "SwiftUI",  id: "P001", question: "What is the primary benefit of using SwiftUI for iOS app development?", choices: [
                Choice(promptId: "P001", text: "Improved performance", isCorrect: false),
                Choice(promptId: "P001", text: "Reduced development time", isCorrect: true),
                Choice(promptId: "P001", text: "Better backward compatibility", isCorrect: false),
                Choice(promptId: "P001", text: "Enhanced security", isCorrect: false),
            ], explanation: "SwiftUI simplifies the process of building user interfaces by using a declarative syntax and providing built-in tools for common tasks, which can significantly reduce the amount of code needed and speed up development time."),
            Prompt(categoryName: "SwiftUI",  id: "P002", question: "How can you create a button with SwiftUI?", choices: [
                Choice(promptId: "P002", text: "Using UIButton class", isCorrect: false),
                Choice(promptId: "P002", text: "Using UILabel class", isCorrect: false),
                Choice(promptId: "P002", text: "Using Text view with onTapGesture modifier", isCorrect: true),
                Choice(promptId: "P002", text: "Using UIImageView class", isCorrect: false),
            ], explanation: "In SwiftUI, you can create a button using a Text view and apply the onTapGesture modifier to detect taps and trigger actions. This approach provides a simple and flexible way to create interactive elements in SwiftUI interfaces.")
        ]
    }
    
    var choice: Choice {
        return Choice(promptId: "P001", text: "Reduced development time", isCorrect: true)
    }
    
    var history: [History] {
        let prompt = prompts[1]
        return [
            History(categoryName: prompt.categoryName,
                    promptId: prompt.id,
                    isCorrect: true,
                    selectedAnswer: "Using Text view with onTapGesture modifier")
        ]
    }
}
