//
//  PromptsViewModel.swift
//  iStudy
//
//  Created by Anthony Williams on 3/24/24.
//

import SwiftUI

class PromptsViewModel: ObservableObject {
    @Published var selection: Choice?
    
    var history: [History] = []
    
    func updateSelection(for prompt: Prompt) {
        guard
            let pastHistory = history.first(where: { $0.promptId == prompt.id }),
            let choice = prompt.choices.first(where: { $0.text == pastHistory.selectedAnswer})
        else { return }
        
        selection = choice
    }
}
