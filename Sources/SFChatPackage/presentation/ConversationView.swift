//
//  ConversationView.swift
//  SFChatPackage
//

import SwiftUI
import UIKit
import Foundation
import SMIClientUI
import SwiftUICore

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
                
                // Right star button as NavigationLink
                NavigationLink(destination: NextScreenView()) {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .navigationBarTitle(NSLocalizedString("conversation_title", comment: "Customer support"), displayMode: .inline)
        }
    }
}

@MainActor
public struct NextScreenView: View {
    public var body: some View {
        VStack {
            Text("Next Screen Content")
                .font(.title)
                .padding()
            Spacer()
        }
        .navigationBarTitle(NSLocalizedString("next_screen_title", comment: "Next Screen Header"), displayMode: .inline)
    }
}

@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = SFChat.shared.config!
    
    public var body: some View {
        Interface(config)
    }
}
