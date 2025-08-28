//
//  SFChat.swift
//  SFChatPackage
//

import SMIClientUI
import SMIClientCore
import SwiftUICore
import ServiceCloud

public class SFChat: @unchecked Sendable {
    let conversationID = UUID()
    let state = SFChatState()
    public static let shared = SFChat()
    
    var config: UIConfiguration?
    
    public init() {}
    
    // MARK: - Setup chat configuration
    public func setup(conf: SFConfig) {
        let orgId = conf.organizationID
        let developerName = conf.developerName
        let conversationId = UUID(uuidString: conf.conversationId)!
        let url = URL(string: conf.scrt2URL)!
        
        // Apply header/branding before showing the chat
        configureAppearance()
        
        DispatchQueue.main.async {
            SFChat.shared.config = UIConfiguration(
                serviceAPI: url,
                organizationId: orgId,
                developerName: developerName,
                conversationId: conversationId
            )
            SFChat.shared.state.isConfigured = true
            SFChat.shared.state.objectWillChange.send()
        }
    }
    
    // MARK: - Configure Salesforce appearance
    private func configureAppearance() {
        let appearance = SCAppearanceConfiguration()
        
        // Header background color
        appearance.setColor(
            UIColor(red: 0.1, green: 0.6, blue: 0.9, alpha: 1.0),
            forName: .brandPrimary
        )
        
        // Header text & icons
        appearance.setColor(
            UIColor.white,
            forName: .brandSecondaryInverted
        )
        
        // Apply configuration to Salesforce SDK
        ServiceCloud.shared().appearanceConfiguration = appearance
    }
    
    // MARK: - Helper to check readiness
    public static var isReady: Bool {
        return SFChat.shared.state.isConfigured
    }
    
    public static var sharedConfig: UIConfiguration? {
        return SFChat.shared.config
    }
}
