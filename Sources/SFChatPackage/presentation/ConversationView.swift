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
                if SFChat.isReady, let config = SFChat.sharedConfig {
                    Interface(config)   
                } else {
                    Text("Loading... \(now)")
                        .onReceive(timer) { _ in
                            self.now = Date()
                        }
                }
            }         
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Left back button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if let topVC = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                            // topVC.dismiss(animated: true)
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    }
                }
                
                // Center title
                ToolbarItem(placement: .principal) {
                    Text(NSLocalizedString("conversation_title", comment: "Conversation Header"))
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                // Right button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Right button tapped")
                    }) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
