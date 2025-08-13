//
//  SFChatApp.swift
//  SFChat
//
//  Created by Vivek Kumar on 28/07/25.
//

import SwiftUI
import SwiftData

@main
struct SFChatApp: App {
    
    var sharedModelContainer: ModelContainer = {
        ChatAppSetup().setup()
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
