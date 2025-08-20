//
//  File.swift
//  SFChatPackage
//
//  Created by Vivek Kumar on 20/08/25.
//

import Foundation
import SMIClientCore
class SFChatCore :@unchecked Sendable{
    public static let shared = SFChatCore()
    var config : Configuration?
    var client : CoreClient?
    var conversationClient : ConversationClient?
    var delegate = SFChatCoreDelegate()
    var conversatinoDelegate = SFChatConversationDelegate()
    func testSetup() {
        let config = StaticData().config
        let url = URL(string: config.scrt2URL)!
        SFChatCore.shared.config = Configuration(serviceAPI: url,organizationId: config.organizationID,developerName: config.developerName)
        SFChatCore.shared.client = CoreFactory.create(withConfig: SFChatCore.shared.config!)
        SFChatCore.shared.client?.addDelegate(delegate: delegate)
        SFChatCore.shared.client?.start()
        let conversationID = UUID()
        SFChatCore.shared.conversationClient = SFChatCore.shared.client!.conversationClient(with: conversationID)
        SFChatCore.shared.conversationClient?.addDelegate(delegate: conversatinoDelegate)
        SFChatCore.shared.conversationClient?.send(message: "it worked")
        //
    }
}
