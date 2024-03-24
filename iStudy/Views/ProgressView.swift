//
//  MainView.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

/// Displays the list of categories and the amount of
/// questions answered / questions asked (for each category)
struct ProgressView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.persistenceManager) private var persistenceManager
    
    @Query(sort: \Category.name, order: .forward) private var categories: [Category]
    @Query private var history: [History]

    var body: some View {
        VStack {
            if let statsText = persistenceManager.stats(category: nil) {
                Text (statsText)
                    .font(.caption)
                    .padding()
            }
            
            List(categories) { category in
                NavigationLink {
                    PromptsView(category: category)
                } label: {
                    createCategoryView(category: category)
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle("Progress", displayMode: .inline)
    }
    
    func createCategoryView(category: Category) -> some View {
        HStack {
            Text(category.name)
            
            Spacer()
            
            if let statsText = persistenceManager.stats(category: category) {
                Text(statsText)
                    .font(.caption)
            }
        }
    }
}
