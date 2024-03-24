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
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isGameOver {
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
                    viewModel.startOver()
                },
            trailing:
                NavigationLink(destination: ProgressView()) {
                    Text("Progress")
                }
        )
        .modelContext(modelContext)
        .onAppear {
            if persistenceManager.modelContext == nil || viewModel.persistenceManager == nil {
                persistenceManager.modelContext = modelContext
                viewModel.persistenceManager = persistenceManager
            }
            
            viewModel.history = history
            viewModel.prompts = prompts
            
            if viewModel.prompt == nil {
                viewModel.next()
            }
        }
        .onChange(of: viewModel.selection) {
            guard let selection = viewModel.selection else { return }
            viewModel.choiceSelected(selection)
        }
        .onChange(of: history) {
            viewModel.history = history
        }
        .onChange(of: prompts) {
            viewModel.prompts = prompts
        }
    }
    
    private var gameView: some View {
        VStack {
            Text(statsText)
                .font(.caption)
                .padding(.top, Spacing.large)
                .padding(.bottom, Spacing.xxSmall)
            
            Text("\(viewModel.unansweredQuestions) questions left")
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
                
            Text(statsText)
                .font(.title)
                .padding(.bottom, Spacing.large)
            
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
        if let stats = persistenceManager.stats(category: nil) {
            return stats
        }
        return "Select an answer to start"
    }
}
