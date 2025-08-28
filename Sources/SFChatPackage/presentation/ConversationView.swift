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
    public init() {}

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
            }
            .navigationBarTitle("Support", displayMode: .inline)
            .navigationBarItems(leading: Button("Close") {
                if let topVC = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                    topVC.dismiss(animated: true)
                }
            })
            .onAppear {
                // Configure navigation bar appearance
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                
                // Header background color (hardcoded or hex)
                appearance.backgroundColor = UIColor(red: 0.1, green: 0.6, blue: 0.9, alpha: 1.0) // light blue example
                
                // Header title color
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

                // Tint for back/close buttons
                UINavigationBar.appearance().tintColor = UIColor.white

                // Apply appearance
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = SFChat.shared.config!
    
    public var body: some View {
        Interface(config)
    }
}
