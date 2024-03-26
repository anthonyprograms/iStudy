//
//  PromptsView.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

/// Displays the list of questions that have already been answered in a category
struct PromptsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [History]
    
    @StateObject private var viewModel = PromptsViewModel()
    
    let category: Category
    
    private var completedPrompts: [Prompt] {
        let historyPromptIds = Set(history.map { $0.promptId })
        return category.prompts.filter { historyPromptIds.contains($0.id) }
    }
    
    var body: some View {
        VStack {
            if completedPrompts.isEmpty {
                noPromptsView
            } else {
                completedPromptsView
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Questions", displayMode: .inline)
        .onAppear {
            viewModel.history = history
        }
    }
    
    private var noPromptsView: some View {
        VStack {
            Text("You have not answered a \(category.name) question yet")
                .padding()
            
            Spacer()
        }
    }
    
    private var completedPromptsView: some View {
        List {
            ForEach(completedPrompts) { prompt in
                NavigationLink(
                    destination: HistoryView(prompt: prompt, selection: $viewModel.selection).onAppear {
                        viewModel.updateSelection(for: prompt)
                    },
                    label: {
                        HStack {
                            Text(prompt.question)
                                .font(iStudyFont.medium)
                                .padding(.vertical, Spacing.xSmall)
                            
                            Spacer()
                            
                            completionStateView(prompt: prompt)
                        }
                    }
                )
            }
        }
    }
    
    private func completionStateView(prompt: Prompt) -> some View {
        if let historyItem = history.first(where: { $0.promptId == prompt.id }) {
            if historyItem.isCorrect {
                return Image(systemName: SystemImages.checkmarkCircleFill)
                    .foregroundColor(.green)
                    .eraseToAnyView()
            } else {
                return Image(systemName: SystemImages.xCircleFill)
                    .foregroundColor(.red)
                    .eraseToAnyView()
            }
        }
        
        return EmptyView().eraseToAnyView()
    }
}
