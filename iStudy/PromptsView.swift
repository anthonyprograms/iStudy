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
    
    let category: Category
    @State private var selection: Choice?
    
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
                    destination: HistoryView(prompt: prompt, selection: $selection).onAppear {
                        updateSelection(for: prompt)
                    },
                    label: {
                        HStack {
                            Text(prompt.question)
                                .font(.system(size: 16.0))
                                .padding(.vertical, Spacing.xSmall)
                            
                            Spacer()
                            
                            completionStateView(prompt: prompt)
                        }
                    }
                )
            }
        }
    }

    private func updateSelection(for prompt: Prompt) {
        guard
            let pastHistory = history.first(where: { $0.promptId == prompt.id }),
            let choice = prompt.choices.first(where: { $0.text == pastHistory.selectedAnswer})
        else { return }
        
        selection = choice
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
