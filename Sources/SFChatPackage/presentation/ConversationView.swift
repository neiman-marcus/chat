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
        NavigationStack {                // ← Wrap everything in NavigationStack
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
            .navigationTitle("Support")   // ← This is the header title
            .toolbar {                     // ← This adds buttons in the header
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {     // ← Close button in header
                        if let topVC = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                            topVC.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
}
