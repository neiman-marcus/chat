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

    public var body: some View {
        NavigationView {
            VStack {
                if SFChat.isReady {
                    if var config = SFChat.sharedConfig {
                        // ✅ Disable file/attachment picker to prevent freeze
                        config.isFileSelectionEnabled = false
                        Interface(config)
                    }
                } else {
                    Text("Loading... \(now)")
                        .onReceive(timer) { _ in
                            self.now = Date()
                        }
                }
            }
            .navigationBarItems(leading: Button(action: {
                if let topVC = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                    topVC.dismiss(animated: true)
                }
            }) {
                Image(systemName: "chevron.backward") 
                    .foregroundColor(.white) 
            })
        }
    }
}

@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = {
        var conf = SFChat.shared.config!
        conf.isFileSelectionEnabled = false // ✅ same fix here
        return conf
    }()

    public var body: some View {
        Interface(config)
    }
}
