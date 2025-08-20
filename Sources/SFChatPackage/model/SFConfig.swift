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
    public let onPrimary: String
    public let onPrimaryContainer: String
    public let primary: String
    public let primaryContainer: String
    public let secondary: String
    public let secondaryContainer: String
    public let primaryVariant: String?
    public let onSecondary: String?
    public let secondaryActive: String?
    public let secondaryHighlight: String?
    public let onSecondaryVariant: String?
    public let background: String?
    public let onBackground: String?
    public let surface: String?
    public let onSurface: String?
    public let surfaceHighlight: String?
    public let surfaceVariant: String?
    public let onSurfaceVariant: String?
    public let surfaceSecondary: String?
    public let surfaceSecondaryVariant: String?
    public let tertiary: String?
    public let highlight: String?
    public let error: String?
    public let warning: String?
    public let success: String?
    public let transparent: String?
    public let backgroundTransparent: String?
    public let surfaceTransparent: String?
    public let onSecondaryTransparent: String?
    public let onSecondarySemiTransparent: String?
    public let onBackgroundSemiTransparent: String?

    enum CodingKeys: String, CodingKey {
        case onPrimary = "SMI.onPrimary"
        case onPrimaryContainer = "SMI.onPrimaryContainer"
        case primary = "SMI.primary"
        case primaryContainer = "SMI.primaryContainer"
        case secondary = "SMI.secondary"
        case secondaryContainer = "SMI.secondaryContainer"
        case primaryVariant = "SMI.primaryVariant"
        case onSecondary = "SMI.onSecondary"
        case secondaryActive = "SMI.secondaryActive"
        case secondaryHighlight = "SMI.secondaryHighlight"
        case onSecondaryVariant = "SMI.onSecondaryVariant"
        case background = "SMI.background"
        case onBackground = "SMI.onBackground"
        case surface = "SMI.surface"
        case onSurface = "SMI.onSurface"
        case surfaceHighlight = "SMI.surfaceHighlight"
        case surfaceVariant = "SMI.surfaceVariant"
        case onSurfaceVariant = "SMI.onSurfaceVariant"
        case surfaceSecondary = "SMI.surfaceSecondary"
        case surfaceSecondaryVariant = "SMI.surfaceSecondaryVariant"
        case tertiary = "SMI.tertiary"
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
