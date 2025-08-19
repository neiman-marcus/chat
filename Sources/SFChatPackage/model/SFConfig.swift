//
//  SFConfig.swift
//  chat
//
//  Created by Vivek Kumar on 28/07/25.
//
public struct SFConfig: Codable {
    let organizationID, developerName: String
    let url: String
    let scrt2URL : String
    public var conversationId : String

    enum CodingKeys: String, CodingKey {
        case organizationID = "OrganizationId"
        case developerName = "DeveloperName"
        case url = "Url"
        case scrt2URL = "scrt2URL"
        case conversationId = "conversation_id"
    }
}


public struct SFTheme: Codable {
    let onPrimary, onPrimaryContainer, primary, primaryContainer, secondary, secondaryContainer: String

    enum CodingKeys: String, CodingKey {
        case onPrimary = "SMI.onPrimary"
        case onPrimaryContainer = "SMI.onPrimaryContainer"
        case primary = "SMI.primary"
        case primaryContainer = "SMI.primaryContainer"
        case secondary = "SMI.secondary"
        case secondaryContainer = "SMI.secondaryContainer"
    }
}
