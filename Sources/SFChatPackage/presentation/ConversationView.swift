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
    public init() {
        // Configure global UINavigationBar appearance
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
    @State private var isChatActive = false // Track navigation state
    let timer = Timer.publish(every: 3, on: .current, in: .common).autoconnect()
    @Environment(\.dismiss) private var dismiss // Modern dismiss API (iOS 15+)

    private func applyNavigationBarAppearance() {
        // Re-apply navigation bar appearance
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
                    NavigationLink(
                        destination: Interface(config)
                            .navigationTitle("SMI.Chat.Feed.Title")
                            .navigationBarItems(leading: Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.white)
                            }),
                        isActive: $isChatActive
                    ) {
                        EmptyView() // Invisible trigger
                    }
                    .hidden() // Hide the NavigationLink
                    .onAppear {
                        isChatActive = true
                        print("ConversationView appeared, isChatActive: \(isChatActive)")
                        applyNavigationBarAppearance() // Re-apply on appear
                    }
                    .onDisappear {
                        isChatActive = false
                        print("ConversationView disappeared, isChatActive: \(isChatActive)")
                    }
                    .navigationTitle("SMI.Chat.Feed.Title")
                    .navigationBarItems(leading: Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    })
                } else {
                    Text("Loading... \(now)")
                        .onReceive(timer) { _ in
                            self.now = Date()
                        }
                        .navigationTitle("SMI.Chat.Feed.Title")
                        .navigationBarItems(leading: Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.white)
                        })
                        .onAppear {
                            applyNavigationBarAppearance() // Re-apply for loading state
                        }
                }
            }
            .navigationViewStyle(.stack) // Enforce single stack navigation
            .onAppear {
                applyNavigationBarAppearance() // Initial appearance setup
            }
        }
    }
}

@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = SFChat.shared.config!
    @Environment(\.dismiss) private var dismiss

    private func applyNavigationBarAppearance() {
        // Re-apply navigation bar appearance
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
        Interface(config)
            .navigationTitle("SMI.Chat.Feed.Title")
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
            })
            .onAppear {
                applyNavigationBarAppearance() // Re-apply on appear
            }
    }
}