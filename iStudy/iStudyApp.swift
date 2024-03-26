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
    @Environment(\.persistenceManager) var persistenceManager: PersistenceManager

    var body: some Scene {
        WindowGroup {
            NavigationView {
                let isTesting = ProcessInfo.processInfo.arguments.contains("IS_TESTING")
                GameView(shouldActivateGameView: !isTesting)
            }
        }
        .modelContainer(persistenceManager.sharedModelContainer)
    }
}
