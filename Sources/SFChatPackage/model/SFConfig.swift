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
        case primary = "SMI.primary"	
        case primaryVariant= "SMI.primaryVariant"
        case onSecondary = "SMI.onSecondary"
        case secondaryActive = "SMI.secondaryActive"
        case secondaryHighlight = "SMI.secondaryHighlight"	
        case onSecondaryVariant = "​​SMI.onSecondaryVariant"
        case background = "SMI.background"
        case onBackground = "SMI.onBackground"	
        case surface = "SMI.surface"	
        case onSurface = "SMI.onSurface"
        case surfaceHighlight = "SMI.surfaceHighlight"
        case surfaceVariant = "SMI.surfaceVariant"
        case onSurfaceVariant = "SMI.onSurfaceVariant"
        case surfaceSecondary = "SMI.surfaceSecondary"
        case surfaceSecondaryVariant = "SMI.surfaceSecondaryVariant"
        case tertiary ="SMI.tertiary"	
        case highlight = "SMI.highlight"
        case error = "SMI.error"
        case warning = "SMI.warning"
        case success = "SMI.success"
        case transparent = "SMI.transparent"	
        case backgroundTransparent = "SMI.backgroundTransparent"
        case surfaceTransparent = "SMI.surfaceTransparent"	
        case onSecondaryTransparent = "SMI.onSecondaryTransparent"
        case onSecondarySemiTransparent = "SMI.onSecondarySemiTransparent"	
        case onBackgroundSemiTransparent = "SMI.onBackgroundSemiTransparent"
    }
}
