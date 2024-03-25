//
//  iStudyApp.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI
import SwiftData

@main
struct iStudyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Category.self,
            Prompt.self,
            Choice.self,
            History.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                let isTesting = ProcessInfo.processInfo.arguments.contains("IS_TESTING")
                GameView(shouldActivateGameView: !isTesting)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
