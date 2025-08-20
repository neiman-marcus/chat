//
//  SFChatCoreDelegate.swift
//  SFChatPackage
//
//  Created by Vivek Kumar on 20/08/25.
//
import SMIClientCore
class SFChatCoreDelegate : NSObject, CoreDelegate {
    
    // Received incoming conversation entries
    func core(_ core: CoreClient,
              conversation: Conversation,
              didReceiveEntries entries: [ConversationEntry],
              paged: Bool) {
      // TO DO: Handle event
    }

    // Message status has changed
    func core(_ core: CoreClient,
              conversation: Conversation,
              didUpdateEntries entries: [ConversationEntry]) {
        // TO DO: Handle event
      }

    // Conversation was created
    func core(_ core: CoreClient,
              didCreateConversation conversation: Conversation) {
        // TO DO: Handle event
      }

    // Received a started typing event
    func core(_ core: CoreClient,
              didReceiveTypingStartedEvent event: ConversationEntry) {
        // TO DO: Handle event
    }

    // Received a stopped typing event
    func core(_ core: CoreClient,
              didReceiveTypingStoppedEvent event: ConversationEntry) {
        // TO DO: Handle event
    }

    // Network status has changed
    func core(_ core: CoreClient,
              didChangeNetworkState state: NetworkConnectivityState) {
        // TO DO: Handle event
        SFChatCore.shared.conversationClient?.send(message: "Hello There`")
    }

    // Received an error message
    func core(_ core: CoreClient, didError error: Error) {
      // TO DO: Handle an error condition!
    }
  }
