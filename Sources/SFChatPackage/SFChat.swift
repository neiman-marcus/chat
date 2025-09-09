//
//  SFChat.swift
//  SFChatPackage
//
//  Created by Vivek Kumar on 28/07/25.
//
//
//  SFChat.swift
//  SFChatPackage
//

import SMIClientUI
import SMIClientCore
import SwiftUICore

public class SFChat: @unchecked Sendable {
    let conversationID = UUID()
    let state = SFChatState()
    public static let shared = SFChat()
    
    var config: UIConfiguration?
    var coreConfig: Configuration?
    var conversationClient: ConversationClient?
    
    public init() {}
    
    private var hasInitialMessageBeenSent = false

    public func setup(conf: SFConfig) {
        let orgId = conf.organizationID
        let developerName = conf.developerName
        let conversationUUID = UUID(uuidString: conf.conversationId)!
        let url = URL(string: conf.scrt2URL)!
        
        var config: Configuration {
            Configuration(serviceAPI: url,
                          organizationId: orgId,
                          developerName: developerName,
                          userVerificationRequired: false)
        }
        
        var remoteLocaleMap: [String: String] {
            var result: [String: String] = [:]
            return result
        }
        
        DispatchQueue.main.async { [self] in
            SFChat.shared.config = UIConfiguration(configuration: config, conversationId: conversationUUID, remoteLocaleMap: remoteLocaleMap, urlDisplayMode: .inlineBrowser)
            SFChat.shared.config?.conversationOptionsConfiguration = ConversationOptionsConfiguration(allowEndChat: true)
            SFChat.shared.config?.transcriptConfiguration = TranscriptConfiguration(allowTranscriptDownload: true)
            SFChat.shared.config?.attachmentConfiguration = AttachmentConfiguration(endUserToAgent: true)
            var coreClient = CoreFactory.create(withConfig: SFChat.shared.config!)
            conversationClient = coreClient.conversationClient(with: conversationUUID)
            
            // Only send initial message if it hasn't been sent yet
            if !hasInitialMessageBeenSent {
                conversationClient?.send(message: "I need customer service assistance.")
                hasInitialMessageBeenSent = true
            }
            
            print("Config done \n \(String(describing: SFChat.shared.config))")
            SFChat.shared.state.isConfigured = true
            SFChat.shared.state.objectWillChange.send()
        }
    }
    
    public func setupTheme(conf: SFTheme) {
        // Theme setup can go here
    }
    
    public func testSetup() {
        let configData = StaticData().config
        let url = URL(string: configData.url)!
        DispatchQueue.main.async {
            SFChat.shared.config = UIConfiguration(serviceAPI: url,
                                                   organizationId: configData.organizationID,
                                                   developerName: configData.developerName,
                                                   conversationId: SFChat.shared.conversationID)
            SFChat.shared.state.isConfigured = true
            SFChat.shared.state.objectWillChange.send()
        }
    }
    
    public func checkIfConnected(callback: @escaping (Bool) -> Void) {
        callback(SFChat.shared.config != nil)
    }
    
    func setupTestCore() {
        SFChatCore.shared.testSetup()
    }
}

// MARK: - Public extension to expose internal properties
public extension SFChat {
    static var isReady: Bool {
        return SFChat.shared.state.isConfigured
    }
    
    static var sharedConfig: UIConfiguration? {
        return SFChat.shared.config
    }
}
