//
//  HistoryView.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

/// Displays the Question View with the answer selected by the user
struct HistoryView: View {
    let prompt: Prompt
    @Binding var selection: Choice?
    
    var body: some View {
        VStack {
            QuestionView(
                prompt: prompt,
                isChoiceSubmitted: true,
                selection: $selection
            )
            
            Spacer()
        }
    }
}
