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
    @Environment(\.dismiss) private var dismiss

    public var body: some View {
        NavigationView {
            VStack {
                if SFChat.isReady, let config = SFChat.sharedConfig {
                    Interface(config)
                    .navigationTitle("SMI.Chat.Feed.Title") // Set title explicitly
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    dismiss() // Use SwiftUI dismiss
                                }) {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                } else {
                    Text("Loading... \(now)")
                        .onReceive(timer) { _ in
                            self.now = Date()
                        }
                        .navigationTitle("SMI.Chat.Feed.Title") // Set title for loading state
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    dismiss() // Use SwiftUI dismiss
                                }) {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                }
            }  
            // .navigationBarItems(leading: Button(action: {
            //     if let topVC = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
            //         topVC.dismiss(animated: true)
            //     }
            // }) {
            //     Image(systemName: "chevron.backward") // back arrow
            //         .foregroundColor(.white) // make it white
            // })  
            .navigationViewStyle(.stack)       
        }
        .onAppear {
            // Re-apply navigation bar appearance to prevent overrides
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

@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = SFChat.shared.config!
    @Environment(\.dismiss) private var dismiss
    public var body: some View {
        Interface(config)
        .navigationTitle("SMI.Chat.Feed.Title") // Set title explicitly
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss() // Use SwiftUI dismiss
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    }
                }
            }
    }
}