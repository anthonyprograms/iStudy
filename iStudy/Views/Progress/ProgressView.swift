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
            if let statsText = statsText(category: nil) {
                Text(statsText)
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
            
            if let statsText = statsText(category: category) {
                Text(statsText)
                    .font(.caption)
            }
        }
    }
    
    private func statsText(category: Category?) -> String? {
        let result: PersistenceManager.HistoryStatsResult
        if let category = category {
            result = persistenceManager.historyStats(category: category)
        } else {
            result = persistenceManager.historyStats()
        }
        
        if result.total == 0 {
            return nil
        }
        
        let percentage = Int((Double(result.resultCount) / Double(result.total)) * 100)
        return "\(result.resultCount)/\(result.total) (\(percentage)%)"
    }
}
