//
//  ConversationView.swift
//  SFChatPackage
//

import SwiftUI
import Foundation
import SMIClientUI
import SwiftUICore
import ServiceCloud

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
            .navigationBarItems(leading: Button("Close") {
                if let topVC = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                    topVC.dismiss(animated: true)
                }
            })
            .onAppear {
                // Configure Salesforce SDK appearance (header colors)
                let appearance = SCAppearanceConfiguration()
                
                appearance.setColor(
                    UIColor(red: 0.1, green: 0.6, blue: 0.9, alpha: 1.0),
                    forName: .brandPrimary
                )
                
                appearance.setColor(
                    UIColor.white,
                    forName: .brandSecondaryInverted
                )
                
                ServiceCloud.shared().appearanceConfiguration = appearance
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
