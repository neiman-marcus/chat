//
//  ContentView.swift
//  SFChat
//
//  Created by Vivek Kumar on 28/07/25.
//

import SwiftUI
import SwiftData
import SFChatPackage
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            ConversationView()
            
        } detail: {
            Text("Select an item")
        }.onAppear{
            print("")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
