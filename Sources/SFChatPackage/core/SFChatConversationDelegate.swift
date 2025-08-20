//
//  SFChatConversationDelegate.swift
//  SFChatPackage
//
//  Created by Vivek Kumar on 20/08/25.
//
import SMIClientCore
class SFChatConversationDelegate: NSObject, ConversationClientDelegate {
    
    // Received conversation entries
    func client(_ client: ConversationClient,
                didReceiveEntries entries: [ConversationEntry], paged: Bool) {
      // TO DO: Handle event
    }

    // Entries changed status
    func client(_ client: ConversationClient,
                didUpdateEntries entries: [ConversationEntry]) {
      // TO DO: Handle event
    }

    // Created a conversation
    func client(_ client: ConversationClient,
                didCreateConversation conversation: Conversation) {
      // TO DO: Handle event
    }

    // Received a started typing event
    func client(_ client: ConversationClient,
                didReceiveTypingStartedEvent event: ConversationEntry) {
      // TO DO: Handle event
    }

    // Received a stopped typing event
    func client(_ client: ConversationClient,
                didReceiveTypingStoppedEvent event: ConversationEntry) {
      // TO DO: Handle event
    }

    // Conversation error
    func client(_ client: ConversationClient,
                didError error: Error) {
      // TO DO: Handle event
    }
  }
