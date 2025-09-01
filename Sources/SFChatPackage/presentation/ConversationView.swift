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
    @Environment(\.dismiss) private var dismiss // Modern dismiss API

    public var body: some View {
        NavigationView {
            VStack {
                if SFChat.isReady, let config = SFChat.sharedConfig {
                    NavigationLink(
                        destination: Interface(config)
                            .navigationTitle("SMI.Chat.Feed.Title")
                            .toolbar(content: {
                                ToolbarItem(placement: .topBarLeading) {
                                    Button(action: {
                                        dismiss()
                                    }) {
                                        Image(systemName: "chevron.backward")
                                            .foregroundColor(.white)
                                    }
                                }
                            }),
                        isActive: $isChatActive
                    ) {
                        EmptyView() // Invisible trigger
                    }
                    .hidden() // Hide the NavigationLink
                    .onAppear {
                        isChatActive = true // Activate chat navigation
                    }
                    .onDisappear {
                        isChatActive = false // Reset when leaving
                    }
                    .navigationTitle("SMI.Chat.Feed.Title")
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.white)
                            }
                        }
                    })
                } else {
                    Text("Loading... \(now)")
                        .onReceive(timer) { _ in
                            self.now = Date()
                        }
                        .navigationTitle("SMI.Chat.Feed.Title")
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarLeading) {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(.white)
                                    }
                                }
                            })
                }
            }
            .navigationViewStyle(.stack) // Enforce single stack navigation
            .onAppear {
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
            .onChange(of: isChatActive) { oldValue, newValue in
                if newValue {
                    // Re-apply navigation bar appearance when returning
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
            }
        }
    }
}

@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = SFChat.shared.config!
    @Environment(\.dismiss) private var dismiss

    public var body: some View {
        Interface(config)
            .navigationTitle("SMI.Chat.Feed.Title")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    }
                }
            })
            .onAppear {
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
    }
}