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
        NavigationView {                // ← Use NavigationView instead of NavigationStack
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
            .navigationBarTitle("Support", displayMode: .inline) // ← Header title
            .navigationBarItems(leading: Button("Close") {    // ← Close button
                if let topVC = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                    topVC.dismiss(animated: true)
                }
            })
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
