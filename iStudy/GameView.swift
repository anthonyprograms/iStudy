//
//  GameView.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

/// The main view hosting the study game
struct GameView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.persistenceManager) var persistenceManager
        
    @Query private var prompts: [Prompt]
    @Query private var history: [History]
    
    @State private var prompt: Prompt?
    @State private var selection: Choice?
    @State private var isGameOver: Bool = false
    @State private var refreshToggle: Bool = false
    
    private var isChoiceSubmitted: Bool {
        selection != nil
    }
    
    var body: some View {
        VStack {
            if isGameOver {
                gameOverView
            } else {
                gameView
            }
        }
        .padding(.horizontal, Spacing.medium)
        .navigationBarTitle("iStudy", displayMode: .inline)
        .navigationBarItems(
            leading:
                Button("Start over") {
                    startOver()
                },
            trailing:
                NavigationLink(destination: ProgressView()) {
                    Text("Progress")
                }
        )
        .modelContext(modelContext)
        .onAppear {
            persistenceManager.modelContext = modelContext
            if prompt == nil {
                next()
            }
        }
        .onChange(of: selection) {
            guard let selection = selection else { return }
            choiceSelected(selection)
        }
        .onChange(of: history) {
            /// A workaround to get the view to refresh the `statsText` after
            /// a History object is inserted into the context
            refreshToggle = !refreshToggle
        }
    }
    
    private var gameView: some View {
        VStack {
            Text(statsText)
                .font(.caption)
                .padding(.vertical, Spacing.large)
            
            if let prompt = prompt {
                QuestionView(
                    prompt: prompt,
                    isChoiceSubmitted: isChoiceSubmitted,
                    selection: $selection
                )
                
                Spacer()
                
                Button(action: {
                    next()
                }) {
                    Text("Next")
                        .font(.system(size: 15.0))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(isChoiceSubmitted ? Color.blue : Color.gray)
                        .cornerRadius(BorderRadius.standard)
                }
                .disabled(!isChoiceSubmitted)

                .padding(.vertical, Spacing.large)
            }
        }
    }
    
    private var gameOverView: some View {
        VStack {
            Text("Your performance:")
                .font(.body)
                
            Text(statsText)
                .font(.title)
                .padding(.bottom, Spacing.large)
            
            Button(action: {
                startOver()
            }) {
                Text("Start over")
                    .font(.system(size: 15.0))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(BorderRadius.standard)
            }
        }
    }
    
    private var statsText: String {
        if let stats = persistenceManager.stats(category: nil) {
            return stats
        }
        return "Select an answer to start"
    }
    
    private func next() -> Void {
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
    
    private func choiceSelected(_ choiceSelection: Choice) {
        guard let prompt = prompt else { return }

        let isCorrect = choiceSelection.isCorrect
        
        let history = History(categoryName: prompt.categoryName,
                              promptId: prompt.id,
                              isCorrect: isCorrect,
                              selectedAnswer: choiceSelection.text)
        modelContext.insert(history)
    }
    
    private func startOver() -> Void {
        persistenceManager.clearHistory()
        prompt = nil
        selection = nil
        isGameOver = false
        
        next()
    }
}
