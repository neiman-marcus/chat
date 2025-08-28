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
        // Apply navigation bar style globally
   let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(named: "SMI.navigationBackground") ?? .white
        navAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "SMI.navigationText") ?? .white
        ]
        navAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "SMI.navigationText") ?? .white
        ]

        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().tintColor = UIColor(named: "SMI.navigationText") ?? .white // buttons in navbar

        // MARK: - Banner Text
        UILabel.appearance(whenContainedInInstancesOf: [UIToolbar.self]).textColor =
            UIColor(named: "SMI.bannerText") ?? UIColor.label

        // MARK: - CTA Buttons
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).tintColor =
            UIColor(named: "SMI.ctaButtons") ?? .white
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor =
            UIColor(named: "SMI.ctaButtons") ?? .white
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(
            UIColor(named: "SMI.ctaButtonsText") ?? .white,
            for: .normal
        )
    
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
            }
            .navigationBarTitle("Support", displayMode: .inline)
            .navigationBarItems(leading: Button("Close") {
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