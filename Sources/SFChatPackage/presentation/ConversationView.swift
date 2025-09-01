//
//  ConversationView.swift
//  SFChatPackage
//

import SwiftUI
import Foundation
import SMIClientUI
import SwiftUICore

@MainActor
public struct ConversationView: View {
    @Environment(\.presentationMode) private var presentationMode // ← Add this
    @State private var now = Date()
    let timer = Timer.publish(every: 3, on: .current, in: .common).autoconnect()

    public init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "SMI.navigationBackground") ?? UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "SMI.navigationText") ?? .white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "SMI.navigationText") ?? .white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(named: "SMI.navigationText") ?? .white
    }

    public var body: some View {
        NavigationView {
            VStack {
                if SFChat.isReady, let config = SFChat.sharedConfig {
                    Interface(config)
                } else {
                    Text("Loading... \(now)")
                        .onReceive(timer) { _ in
                            self.now = Date()
                        }
                }
            }
            .toolbar { // ← Replace navigationBarItems
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // ← Proper SwiftUI dismissal
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // ← Prevents SwiftUI rebuild issues
    }
}

@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = SFChat.shared.config!
    
    public var body: some View {
        Interface(config)
    }
}
