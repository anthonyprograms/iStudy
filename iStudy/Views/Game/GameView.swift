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
        
    @Query private var history: [History]
    
    @StateObject private var viewModel = GameViewModel()
    
    /// Used for testing — we don't want to invoke `.onAppear` or `.task` methods if this value is false
    let shouldActivateGameView: Bool
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                SwiftUI.ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                if viewModel.isGameOver {
                    gameOverView
                } else {
                    gameView
                }
            }
        }
        .padding(.horizontal, Spacing.medium)
        .navigationBarTitle("iStudy", displayMode: .inline)
        .navigationBarItems(
            leading:
                Button("Start over") {
                    viewModel.startOver()
                },
            trailing:
                NavigationLink(destination: ProgressView()) {
                    Text("Progress")
                }
        )
        .modelContext(modelContext)
        .onAppear {
            guard shouldActivateGameView else  { return }
            
            if persistenceManager.modelContext == nil || viewModel.persistenceManager == nil {
                persistenceManager.modelContext = modelContext
                viewModel.persistenceManager = persistenceManager
            }
                        
            viewModel.history = history
        }
        .onChange(of: viewModel.selection) {
            guard let selection = viewModel.selection else { return }
            viewModel.choiceSelected(selection)
        }
        .onChange(of: history) {
            viewModel.history = history
        }
        .task {
            guard shouldActivateGameView else  { return }
            await viewModel.fetchData()
        }
    }
    
    private var gameView: some View {
        VStack {
            Text("\(viewModel.unansweredQuestions) questions left")
                .font(.caption)
                .padding(.top, Spacing.large)
                .padding(.bottom, Spacing.xxSmall)
            
            SwiftUI.ProgressView(value: percentageGameComplete)
            
            Text(statsText)
                .font(.caption)
                .padding(.top, Spacing.xxSmall)
                .padding(.bottom, Spacing.large)
            
            if let prompt = viewModel.prompt {
                QuestionView(
                    prompt: prompt,
                    isChoiceSubmitted: viewModel.isChoiceSubmitted,
                    selection: $viewModel.selection
                )
                
                Spacer()
                
                Button(action: {
                    viewModel.next()
                }) {
                    Text("Next")
                        .font(.system(size: 15.0))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(viewModel.isChoiceSubmitted ? Color.blue : Color.gray)
                        .cornerRadius(BorderRadius.standard)
                }
                .disabled(!viewModel.isChoiceSubmitted)

                .padding(.vertical, Spacing.large)
            }
        }
    }
    
    private var gameOverView: some View {
        VStack {
            Text("Your performance:")
                .font(.body)
                .padding(.top, Spacing.large)
            
            Text(statsText)
                .font(.title)
                .padding(.bottom, Spacing.large)
            
            ResultChartView(
                categories: viewModel.categories,
                history: history
            )
            
            Spacer()
            
            Button(action: {
                viewModel.startOver()
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
        let result = persistenceManager.historyStats(
            correctType: .isCorrect(true),
            totalType: .none
        )
        
        if result.total == 0 {
            return "Select an answer to continue"
        }
        
        let percentage = Int((Double(result.correct) / Double(result.total)) * 100)
        return "\(result.correct)/\(result.total) (\(Int(percentage))%)"
    }
    
    private var percentageGameComplete: Double {
        let result = persistenceManager.questionsCount()
        
        if result.total == 0 {
            return 0
        }
        
        let percentage = Double(result.answered) / Double(result.total)
        return percentage
    }
}
