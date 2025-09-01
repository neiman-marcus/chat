//
//  ConversationView.swift
//  SFChatPackage
//

import SwiftUI
import UIKit
import Foundation
import SMIClientUI
import SwiftUICore

// MARK: - Custom Navigation Bar Modifier
struct CustomNavigationBar: ViewModifier {
    let title: String
    let trailingAction: () -> Void
    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Left: Always show custom back button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    }
                }
                
                // Center: Title
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                // Right: Star button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: trailingAction) {
                        Image(systemName: "star")
                            .foregroundColor(.white)
                    }
                }
            }
    }
}

// MARK: - View Extension
extension View {
    func customNavigationBar(title: String, trailingAction: @escaping () -> Void) -> some View {
        self.modifier(CustomNavigationBar(title: title, trailingAction: trailingAction))
    }
}

// MARK: - Conversation View
@MainActor
public struct ConversationView: View {
    public init() { 
        // UINavigationBar appearance setup
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

    @State private var now = Date()
    let timer = Timer.publish(every: 3, on: .current, in: .common).autoconnect()

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
                Spacer()
            }
            .customNavigationBar(title: NSLocalizedString("conversation_title", comment: "Conversation Header")) {
                print("Star tapped")
            }
        }
    }
}

// MARK: - Conversation Content View
@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = SFChat.shared.config!
    
    public var body: some View {
        Interface(config)
    }
}
