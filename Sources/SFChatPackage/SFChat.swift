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
    
    public init() {}
    
    public func setup(conf: SFConfig) {
        let orgId = conf.organizationID
        let developerName = conf.developerName
        let conversationId = UUID(uuidString: conf.conversationId)!
        let url = URL(string: conf.scrt2URL)!
        
        DispatchQueue.main.async {
            SFChat.shared.config = UIConfiguration(serviceAPI: url,
                                                   organizationId: orgId,
                                                   developerName: developerName,
                                                   conversationId: conversationId)
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
