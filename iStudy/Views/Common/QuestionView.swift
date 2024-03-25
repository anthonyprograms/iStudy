//
//  QuestionView.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

/// Displays the question, choices (as buttons) and the explanation for the question
struct QuestionView: View {
    
    let prompt: Prompt
    let isChoiceSubmitted: Bool
    @Binding var selection: Choice?
    
    var body: some View {
        ScrollView {
            Text(prompt.question)
                .font(iStudyFont.question)
                .padding(.top, Spacing.small)
                .padding(.bottom, Spacing.xxLarge)
            
            createButtonViews(choices: prompt.choices)
                .padding(.bottom, Spacing.medium)
            
            if isChoiceSubmitted {
                Text(prompt.explanation)
                    .font(.caption)
                    .padding()
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    private func createButtonViews(choices: [Choice]) -> some View {
        ForEach(Array(choices.enumerated()), id: \.element) { index, choice in
            ZStack {
                Button(action: {
                    guard !isChoiceSubmitted else { return }
                    withAnimation {
                        selection = choice
                    }
                }) {
                    Text(choice.text)
                        .font(iStudyFont.small)
                        .padding()
                        .frame(minWidth: 200, maxWidth: 250)
                        .foregroundColor(.white)
                        .background(isChoiceSubmitted ? Color.gray : Color.blue)
                        .cornerRadius(BorderRadius.standard)
                }
                .disabled(isChoiceSubmitted)
                
                createResultStateView(choice: choice)
            }
        }
    }
    
    private func createResultStateView(choice: Choice) -> some View {
        // ZStack used to keep these 2 states on the view to be animated
        ZStack {
            createStateView(
                systemName: SystemImages.checkmarkCircleFill,
                foregroundColor: .green,
                isVisible: isChoiceSubmitted && choice.isCorrect
            )
            
            createStateView(
                systemName: SystemImages.xCircleFill,
                foregroundColor: .red,
                isVisible: isChoiceSubmitted && selection?.text == choice.text && !choice.isCorrect
            )
        }
    }
    
    private func createStateView(systemName: String, foregroundColor: Color, isVisible: Bool) -> some View {
        HStack {
            Spacer()
                Image(systemName: systemName)
                    .foregroundColor(foregroundColor)
                    .font(iStudyFont.xLarge)
                    .opacity(isVisible ? 1.0 : 0)
                    .scaleEffect(isChoiceSubmitted ? 1.0 : 0.3)
                    .animation(.easeInOut(duration: 0.2).delay(0.2), value: 1)
        }
    }
}
